
#   Document setup
#######################################################################################
require 'sinatra/base'
require 'sinatra/partial'
require 'rack-flash'
require 'data_mapper'
require_relative 'helpers'
require_relative 'data_mapper_setup'




#   Bookmark Manager App
#######################################################################################

class BookmarkManager < Sinatra::Base
  register Sinatra::Partial
  set :partial_template_engine, :erb
  set :views, File.join(File.dirname(__FILE__), '..', 'views')
  enable :sessions
  set :session_secret, "I'm the secret key to sign the cookie"

  set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')
  use Rack::Flash, :sweep => true
  use Rack::MethodOverride
  helpers UsersHelper


  get '/' do
  	@links = Link.all
  	erb :index
  end

  get '/about' do
    erb :about
  end



#   ADDING LINKS
###################################################################

  post '/links' do
  	url = params['url']
  	title = params['title']
  	tags = params['tags'].split(' ').map {|tag| Tag.first_or_create(:text => tag) }
  	Link.create(:url => url, :title => title, :tags => tags)
  	redirect to('/')
  end



#   SORTING BY TAGS
###################################################################
 
  get '/tags/:text' do
  	tag = Tag.first(:text => params[:text])
  	@links = tag ? tag.links : []
  	erb :index
  end



#   USERS
###################################################################

  get '/users/new' do
    @user = User.new
    erb :new_user
  end


  post '/users' do
    @user = User.create(:email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :new_user
    end
  end



#   SESSION
###################################################################

  get '/session/new' do
    erb :new_session
  end


  post '/session' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password are incorrect"]
      erb :new_session
    end
  end


  delete '/session' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end


end





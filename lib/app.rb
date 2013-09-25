
#   Document setup
#######################################################################################
require 'sinatra/base'
require 'rack-flash'
require 'data_mapper'
require_relative 'helpers'
require_relative 'data_mapper_setup'




#   Bookmark Manager App
#######################################################################################

class BookmarkManager < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), '..', 'views')
  enable :sessions
  set :session_secret, "I'm the secret key to sign the cookie"
  use Rack::Flash
  helpers UsersHelper



  get '/' do
  	@links = Link.all
  	erb :index
  end

  post '/links' do
  	url = params['url']
  	title = params['title']
  	tags = params['tags'].split(' ').map {|tag| Tag.first_or_create(:text => tag) }
  	Link.create(:url => url, :title => title, :tags => tags)
  	redirect to('/')
  end

  get '/tags/:text' do
  	tag = Tag.first(:text => params[:text])
  	@links = tag ? tag.links : []
  	erb :index
  end

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

end

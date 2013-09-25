
#   Document setup
#######################################################################################
require 'sinatra/base'
require 'data_mapper'
require_relative 'helpers'
require_relative 'data_mapper_setup'





#   Bookmark Manager App
#######################################################################################

class BookmarkManager < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), '..', 'views')
  enable :sessions
  set :session_secret, "I'm the secret key to sign the cookie"
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
    erb :new_user
  end

  post '/users' do
    user = User.create(:email => params[:email],
                :password => params[:password])
    session[:user_id] = user.id
    redirect to('/')
  end

end

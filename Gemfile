source 'https://rubygems.org'

ruby '2.0.0'

gem 'sinatra' # Framework for this app
gem 'haml'
gem 'sass' # extension for CSS3 adding nested rules, vars, mixins, etc..
gem 'data_mapper'
gem 'rack-flash3' #gem to allow for flash updates when pressing buttons
gem 'sinatra-partial'
gem 'dm-timestamps' #adds time automatically for database interactions
gem 'multimap'

group :development, :test do
	gem 'shotgun' # gem to allow for auto-update of the files to the server
	gem 'rspec' # gem to test the ruby code
	gem 'cucumber' # tool that sits on top of capybara to run tests	written in plain english
	gem 'capybara' # tool to test web applications
	gem 'cucumber-sinatra' # helps initialize a cucumber environment for sinatra apps
	gem 'guard'
	gem 'guard-cucumber'
	gem 'guard-rspec'
	gem 'database_cleaner'
end

group :production do
	gem 'dm-postgres-adapter'
	gem 'pg'

end


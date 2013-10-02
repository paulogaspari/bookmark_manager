require 'data_mapper'
require './lib/data_mapper_setup'

task :auto_migrate do
	DataMapper.auto_migrate!
	puts 'Auto-migrate complete (data loss)'
end

task :auto_upgrade do
	DataMapper.auto_upgrade!
	puts "Auto-upgrate complete (No data was lost)"
end

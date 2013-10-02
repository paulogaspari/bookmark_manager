require 'bcrypt'

class User


	include DataMapper::Resource

	has n, :links

	property :id, 				Serial
	property :email, 			String, format: :email_address, :unique => true, :message=> 'This email is already taken'
	property :password_digest, 	Text
	property :username, 		String, :unique => true, :message=> 'This username is already taken'
	property :firstname,		String, length: 1..50, :message=> "I don't believe your name is more than 50 characters. Check if right"
	property :lastname,			String, length: 1..50, :message=> "I don't believe your lastname is more than 50 characters. Check if right"

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password, :message=> "Sorry, your passwords don't match"
	validates_uniqueness_of :email	
	validates_uniqueness_of :username	

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
    	user = first(:email => email)
	    user if user && BCrypt::Password.new(user.password_digest) == password
 	end


end
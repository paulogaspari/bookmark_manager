require 'spec_helper'

feature 'User signs out' do

	before(:each) do
		User.create(:email => "test@test.com", 
                :password => 'test', 
                :password_confirmation => 'test')
	end

	def sign_in(email, password)
		visit '/session/new'
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'
	end

	scenario 'while being signed in' do
		visit '/'
		sign_in('test@test.com', 'test')
		click_button 'Sign out'
		expect(page).to have_content('Good bye!')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end


module UsersHelper

    def current_user    
      @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end

    def send_welcome_message
	  RestClient.post "https://api:key-2-rcikfklser8dpmjuscjy9taad59a57"\
	  "@api.mailgun.net/v2/samples.mailgun.org/messages",
	  :from => "Excited User <me@samples.mailgun.org>",
	  :to => @user.email,
	  :subject => "Thank you for registering with Linkly.io",
	  :text => "Hello #{@user.firstname}! Testing some Mailgun awesomness!"
	end

end
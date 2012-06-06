class ApplicationController < ActionController::Base
  protect_from_forgery
 
  private
  
		def only_when_user_is_logged_in
			redirect_to login_path if !User.find_by_username(session[:current_user])
		end
end

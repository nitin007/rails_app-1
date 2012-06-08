class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
	  
	def current_user
		User.find(session[:current_user_id])
	end
 
  private
  
		def only_when_user_is_logged_in
			redirect_to login_index_path if !User.find_by_username(session[:current_user])
		end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
	  
	def current_user
    # OPTIMIZE: WA: When you make multiple calls to
    # current_user in your controllers' actions, views and
    # helpers, following SQL query will be fired up that many times.
    # Try to use ||= operator. Read about it at:
    # http://www.rubyinside.com/what-rubys-double-pipe-or-equals-really-does-5488.html
		User.find(session[:current_user_id])
	end
 
  private
  
		def only_when_user_is_logged_in
			redirect_to login_index_path if !User.find_by_username(session[:current_user])
		end
end

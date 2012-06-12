class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
	  
	def current_user
    # Optimized: NG
    # FIXME: WA: current_user below is an local variable.
    # It will cease to exist as soon as the method finishes.
    # Use an instance variable instead.
		current_user ||= User.find(session[:current_user_id])
	end
	
  # REFACTOR: WA: You need not define following method
  # in application controller. Define it in the controller
  # where you need it.
	def fetch_image
		begin
#			@image ||= current_user.albums.find(params[:album_id]).images.find(params[:id])
      #	FIXME: WA: Following will fetch any image for display, destruction.
      #	Not neccessarily current user's.
			@image ||= Image.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to album_path(current_album) and return
		end
	end
 
  private
  
		def only_when_user_is_logged_in
			redirect_to logins_path if !User.find_by_username(session[:current_user])
		end
end

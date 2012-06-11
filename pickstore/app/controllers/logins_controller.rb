class LoginsController < ApplicationController
	before_filter :only_when_user_is_logged_in, :only => :logout

	def index
		respond_to do |format|
      format.html      
    end
  end
  
 	def login
		respond_to do |format|
			user = User.find_by_username(params[:username])
			if user && user.authenticate(params[:password])
				session[:current_user] = user.username
				session[:current_user_id] = user.id
				flash[:notice] = "You have logged in successfully!"
				format.html { redirect_to albums_path }
			else
				format.html { redirect_to logins_path, notice: 'username or password is incorrect!'}
			end
		end
	end
	
  # FIXME: WA: Please make a check in a bfore filter
  # if a user is signe in before executing this action.
  # Fixed: NG
	def logout
		session[:current_user_id] = nil
		redirect_to logins_path
	end
end

class LoginController < ApplicationController
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
				format.html { redirect_to login_index_path, notice: 'username or password is incorrect!'}
			end
		end
	end
	
	def logout
		session[:current_user] = nil
		redirect_to login_index_path
	end
end

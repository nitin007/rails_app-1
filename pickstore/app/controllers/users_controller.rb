class UsersController < ApplicationController
	def index
		respond_to do |format|
      format.html      
    end
  end
  
	def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end
		
	def create
	  @user = User.new(params[:user])

	  respond_to do |format|
	    if @user.save
	    	session[:current_user] = @user.username
	    	session[:current_user_id] = @user.id
	      format.html { redirect_to albums_path, notice: 'You are successfully registered!' }
	    else
	      format.html { render :action => "new" }
	    end
	  end
	end
	
	def login
		respond_to do |format|
			if user = User.authenticate(params[:username], params[:password])
				session[:current_user] = user.username
				session[:current_user_id] = user.id
				flash[:notice] = "You have logged in successfully!"
				format.html { redirect_to albums_path }
			else
				format.html { redirect_to login_path, notice: 'username or password is incorrect!'}
			end
		end
	end
	
	def logout
		session[:current_user] = nil
		redirect_to login_path
	end
end

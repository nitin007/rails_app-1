class UsersController < ApplicationController
  # FIXME: WA: /users should be used to list
  # your users and not show a log in form.
  # For login logout, create a separate
  # controller.

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
	
  # FIXME: WA: This should be moved to
  # another controller that handles
  # logins
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
	
  # FIXME: WA: This should be moved to
  # another controller that handles
  # login logout

  # FIXME: WA: Before logging a user out
  # you should check if a user is loggedin
  # in a before filter.
	def logout
		session[:current_user] = nil
		redirect_to login_path
	end
end

require 'spec_helper'

describe UsersController, :type => :controller do
	it "shows login page when index is called" do
		get :index
		response.should be_success
	end
	
	it "should render with empty new user" do
		get :new
		response.should be_success		
	end
	
	context "creates a new user" do
		it "should redirect to albums path with notice on successful registered" do
      # TODO: WA: Write controller tests in isolation of your
      # database. Use stubs and mocks.
			post :create, :user => {:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef"}
			flash[:notice].should_not be_nil
			session[:current_user].should_not be_nil
			session[:current_user_id].should_not be_nil			
			response.should redirect_to(albums_path)
		end
		
		it "should re-render new template on failed registration" do
			post :create, :user => {:username => "nitin"}
			flash[:notice].should be_nil
			response.should render_template('new')
		end
	end
	
	context "redirects user" do
		it "on successful login to albums path" do
			post :login, :username => "nitin", :password => "abcdef"
			flash[:notice].should == "You have logged in successfully!"
			response.should redirect_to(albums_path)		
		end
		
		it "on unsuccessful login to login path" do
			post :login, :username => "nitin", :password => "12345678"
			flash[:notice].should == "username or password is incorrect!"
			response.should redirect_to(login_path)		
		end
	end
	
	it "should redirects user to login page on logout" do
		post :logout
		session[:current_user].should be_nil
		response.should redirect_to(login_path)
	end
end

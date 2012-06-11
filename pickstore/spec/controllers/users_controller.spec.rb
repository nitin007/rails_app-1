require 'spec_helper'

describe UsersController, :type => :controller do	
	it "should render with empty new user" do
		get :new
		response.should be_success		
	end
	
	context "creates a new user" do
		it "should redirect to albums path with notice on successful registered" do
      #Fixed NG
		  User.stub!(:new) {mock_model('User', :save => true)}
			post :create
			flash[:notice].should_not be_nil
			response.should redirect_to(albums_path)
		end
		
		it "should re-render new template on failed registration" do
      # TODO: WA: Write controller tests in isolation of your
      # database. Use stubs and mocks.
      #Fixed: NG
		  User.stub!(:new) {mock_model('User', :save => false)}
			post :create
      
			flash[:notice].should be_nil
			response.should render_template('new')
		end
	end
	
  # REFACTOR: WA: We do not need following tests for UsersController
  # Refactored: NG
end

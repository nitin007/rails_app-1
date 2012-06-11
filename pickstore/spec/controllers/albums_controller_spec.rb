require 'spec_helper'

describe AlbumsController, :type => :controller do
	render_views
		
	it "shows all albums when index is called" do
		get :index
		response.should be_success
	end
	
	it "shows the album" do
		get :show, :id => @album.id
		response.should be_success
		assigns(:album).should eq(@user.albums.first)
	end
	
	context "should redirect to albums path" do
		it "when user's album doesn't exists" do
			get :show, :id => 5
			response.should redirect_to(albums_path)
		end
	end
	
	it "should render with empty new album" do
		get :new
		response.should be_success
	end
	
	it "edits the album" do
		get :edit, :id => @album.id
		response.should be_success
		assigns(:album).should eq(@user.albums.first)
	end
	
	context "should redirect to albums path" do
		it "when user's album(for editing) doesn't exists" do
			get :edit, :id => 5
			response.should redirect_to(albums_path)
		end
	end
	
	context "creates a new album" do
		it "should redirect to saved album with a notice on successful save " do
			post :create, :album => {:name => @album.name, :user_id => @user.id}
			flash[:notice].should_not be_nil
			response.should be_redirect
		end
		
		it "should re-render new template on failed save" do
			post :create, :album => {}
			flash[:notice].should be_nil
			response.should render_template('new')
		end
	end
	
	context "updates an existing album" do
		it "should redirect to upadted album with a notice on successful update" do
			put :update, :id => @album.id
			flash[:notice].should_not be_nil
			response.should redirect_to(album_path(@album))
		end
		
		it "should re-render edit template on failed update" do
			put :update, :id => @album.id, :album => {:name => ""}
			flash[:notice].should be_nil
			response.should render_template('edit')
		end
	end
	
	context "destroying a post" do
		it "should redirect to index action on album destroy" do
			delete :destroy, :id => @album.id
			response.should redirect_to(albums_path)
		end
	end
end

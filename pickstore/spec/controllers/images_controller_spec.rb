require 'spec_helper'

describe ImagesController, :type => :controller do
	render_views
	fixtures :albums, :images
	
	before(:each) do
		@album = albums(:one)
		@image = images(:one)
	end
	
	it "shows an image when show action is called" do
		get :show, :id => @image.id, :album_id => @album.id
		response.should be_success
		assigns(:image).should eq(@album.images.first)
	end
	
	it "should destroy image" do
		delete :destroy, :id => @image.id, :album_id => @album.id
		response.should redirect_to(album_path(@album))
	end
end

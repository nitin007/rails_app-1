require 'spec_helper'

describe Album do
	context "with its attributes empty" do
		it "should be invalid" do
			@album = Album.new
			@album.should_not be_valid
			@album.should have(1).error_on(:name)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@album = Album.new(:name => "MyString", :user_id => 1)
			@album.should be_valid
		end
	end
	
	context "association" do
		it "with user should be valid" do
      # FIXME: WA: We need not check a users validity in every test.
      # Just create a valid user and test it. One test in your suite
      # should _ideally_ test only one thing.
			@user = User.new(:username => "nitin1", :password => "12345678")
			@user.should be_valid
			@user.save
			@album = @user.albums.new(:name => "Nature")
			@album.should be_valid
		end
		
    # FIXME: WA: What does following test do?
    # Check the validity of an image? Move it
    # to Image's specs.
		it "with images should be valid" do 
			@album = Album.new(:name => "MyString", :user_id => 1)
			@album.should be_valid
			@image = @album.images.new(:picture_file_name => "url.jpg", :picture_content_type => "image", :picture_file_size => 45667, :title => "MyString")
			@image.should be_valid
		end
	end
		
	context "destroys" do
		it "images should destroy" do
			@album = Album.first
			@album.should be_valid
			@image = @album.images.new(:picture_file_name => "url.jpg", :picture_content_type => "image", :picture_file_size => 45667, :title => "MyString")
			@image.save
			@album.destroy
      # FIXME: WA: This test does not test the presence
      # of an image in the database but rather its
      # validity.
			@image.should_not be_valid
		end
	end
end

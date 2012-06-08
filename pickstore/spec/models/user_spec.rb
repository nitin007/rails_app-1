require 'spec_helper'
require 'digest/sha2'

describe User do

	before(:each) do
		@user = User.new(:username => "nitin", :password => "12345678", :password_confirmation => "12345678")
		@user.should be_valid
		@user.save
	end

	context "with its attributes empty" do
		it "should be invalid" do
			@user1 = User.new
			@user1.should_not be_valid
			@user1.should have(1).error_on(:username)
			@user1.should have(1).error_on(:password)
			@user1.should have(0).error_on(:password_confirmation)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@user1 = User.new(:username => "nitin1", :password => "12345678", :password_confirmation => "12345678")
			@user1.should be_valid
		end
	end
	
	context "username" do
		it "sholuld be unique" do
			@user1 = User.new(:username => "nitin", :password => "87654321", :password_confirmation => "87654321")
			@user1.should_not be_valid
		end
	end
	
	context "password and password_confirmation" do 
		it "should be equal" do
			@user1 = User.new(:username => "nitin2", :password => "12345678", :password_confirmation => "123456789")
			@user1.should_not be_valid
			
			@user1 = User.new(:username => "nitin2", :password => "12345678", :password_confirmation => "12345678")
			@user1.should be_valid
		end
	end
	
	context "password length" do
		it "should be greater than or equal to 5" do
			@user1 = User.new(:username => "nitin2", :password => "1234", :password_confirmation => "1234")
			@user1.should_not be_valid
			
			@user1 = User.new(:username => "nitin2", :password => "12345", :password_confirmation => "12345")
			@user1.should be_valid
			
			@user1 = User.new(:username => "nitin2", :password => "1234567", :password_confirmation => "1234567")
			@user1.should be_valid
		end
	end
	
	context "association" do
    # FIXME: WA: What does following test do?
    # Check the validity of an album? Move it
    # to Album's specs.
    
    #Fixed: NG
		it "with albums should be valid" do
      # FIXME: WA: We need not check a users validity in every test.
      # It is already tested in one of the tests above.
      
      #Fixed: NG
			@user1 = User.find_by_username('nitin')
			@album = @user1.albums.new(:name => "Nature")
			@album.user_id.should eq(@user.id)
		end
	end
end

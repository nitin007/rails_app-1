require 'spec_helper'
require 'digest/sha2'

describe User do
	context "with its attributes empty" do
		it "should be invalid" do
			@user = User.new
			@user.should_not be_valid
			@user.should have(1).error_on(:username)
			@user.should have(2).error_on(:password)
			@user.should have(0).error_on(:password_confirmation)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@user = User.new(:username => "nitin2", :password => "12345678", :password_confirmation => "12345678")
			@user.should be_valid
		end
	end
	
	context "username" do
		it "sholuld be unique" do
			@user1 = User.new(:username => "nitin", :password => "12345678", :password_confirmation => "12345678")
			@user1.should be_valid
			@user1.save

			@user2 = User.new(:username => "nitin", :password => "87654321", :password_confirmation => "87654321")
			@user2.should_not be_valid
			@user1.destroy
		end
	end
	
	context "password and password_confirmation" do 
		it "should be equal" do
			@user = User.new(:username => "nitin2", :password => "12345678", :password_confirmation => "123456789")
			@user.should_not be_valid
			
			@user = User.new(:username => "nitin2", :password => "12345678", :password_confirmation => "12345678")
			@user.should be_valid
		end
	end
	
	context "password length" do
		it "should be greater than or equal to 5" do
			@user = User.new(:username => "nitin2", :password => "1234", :password_confirmation => "1234")
			@user.should_not be_valid
			
			@user = User.new(:username => "nitin2", :password => "12345", :password_confirmation => "12345")
			@user.should be_valid
			
			@user = User.new(:username => "nitin2", :password => "1234567", :password_confirmation => "1234567")
			@user.should be_valid
		end
	end
	
	context "association" do
		it "with albums should be valid" do
			@user = User.new(:username => "nitin2", :password => "1234567", :password_confirmation => "1234567")
			@user.should be_valid
			@user.save
			
			@album = @user.albums.new(:name => "Nature")
			@album.should be_valid
			@user.destroy			
		end
	end
	
	context "password before storing into database" do
		it "should be hashed" do
			@user = User.new(:username => "nitin3", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
			@user.save
			@user.password.should be == Digest::SHA512.hexdigest('abcdef')
			@user.destroy
		end
	end
	
	it "authenticates" do
		@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
		@user.should be_valid
		@user.save
		User.authenticate(@user.username, '1234hjki').should == nil
		User.authenticate(@user.username, "abcdef").should be_valid
		@user.destroy
	end
	
	it "should hash password" do
		@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
		@user.hash_password
		@user.password.should be == Digest::SHA512.hexdigest('abcdef')
	end
end

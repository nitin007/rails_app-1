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
      # FIXME: WA: Following line is not needed
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
    # FIXME: WA: What does following test do?
    # Check the validity of an album? Move it
    # to Album's specs.
		it "with albums should be valid" do
			@user = User.new(:username => "nitin2", :password => "1234567", :password_confirmation => "1234567")
      # FIXME: WA: We need not check a users validity in every test.
      # It is already tested in one of the tests above.
			@user.should be_valid
			@user.save
			
			@album = @user.albums.new(:name => "Nature")
			@album.should be_valid
      # FIXME: WA: Following line is not needed
			@user.destroy			
		end
	end
	
	context "password before storing into database" do
		it "should be hashed" do
			@user = User.new(:username => "nitin3", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
			@user.save
      # FIXME: WA: The use of == here might give you
      # "possible useless use of == in void context"
      # warning. Use eql() method provided by rspec.
			@user.password.should be == Digest::SHA512.hexdigest('abcdef')
			@user.destroy
		end
	end
	
	it "authenticates" do
		@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
		@user.should be_valid
		@user.save
		User.authenticate(@user.username, '1234hjki').should == nil
    # FIXME: WA: Following does not test the behavior
    # correctly. User#authenticate returns a user from
    # database. A user in database is supposed to be valid.
    # If someday someone changes that method to return
    # somee other model which is valid, following test
    # will pass but your code will be have a bug.
		User.authenticate(@user.username, "abcdef").should be_valid
		@user.destroy
	end
	
  # FIXME: WA: This has already been tested in a
  # test above.
	it "should hash password" do
		@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
		@user.hash_password
		@user.password.should be == Digest::SHA512.hexdigest('abcdef')
	end
end

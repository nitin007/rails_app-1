require 'spec_helper'

describe Image do
	context "with its attributes empty" do
		it "should be invalid" do
			@image = Image.new
			@image.should_not be_valid
			@image.should have(1).error_on(:title)
			@image.should have(1).error_on(:picture)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@image = Image.new(:title => "abcde", :picture_file_name => "url.jpg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
			@image.should be_valid
		end
	end
	
	context "association" do
		it "with album should be valid" do
			@album = Album.new(:name => "MyString", :user_id => 1)
			@album.should be_valid
			@image = @album.images.new(:title => "abcde", :picture_file_name => "url.jpg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
			@image.should be_valid
		end
		
		it "with tags should be valid" do
			@image = Image.new(:title => "abcde", :picture_file_name => "url.jpg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
			@image.should be_valid
			@tag = @image.tags.new(:name => "abcd")
			@tag.should be_valid
		end
	end
	
	context "destroys" do
		it "should destroy associated tags" do
			@image = Image.new(:title => "abcde", :picture_file_name => "url.jpg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
			@image.should be_valid
			@image.save
			@tag = @image.tags.new(:name => "abcd")
			@tag.save
			@image.destroy
			@tag.should_not be_valid
		end
	end
end

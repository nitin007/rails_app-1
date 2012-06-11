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
      #Fixed: NG
			@image = Image.new(:title => "abcde", :picture => File.new("#{Rails.root}/spec/fixtures/images/rails.png"), :picture_file_name => "url.jpeg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
			@image.should be_valid
		end
	end
	
	context "association" do
		it "with album should be valid" do
			@album = Album.new(:name => "MyString", :user_id => 1)
			@album.should be_valid
			@image = @album.images.new(:title => "abcde", :picture_file_name => "url.jpeg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
			@image.album_id.should eq(@album.id)
		end
	end
	
	context "destroys" do
    # FIXME: WA: This test does not test the presence
    # of an tag in the database but rather its
    # validity.
    
    # Fixed: NG
		it "should destroy associated tags" do
			@image = Image.new(:title => "abcde", :picture => File.new("#{Rails.root}/spec/fixtures/images/rails.png"), :picture_file_name => "url.jpeg", :picture_content_type => "abc", :picture_file_size => 865, :album_id => 2)
      # FIXME: WA: We need not check a image's validity in every test.
      # Just create a valid image and test it. One test in your suite
      # should _ideally_ test only one thing.
      #Fixed: NG
			@image.save
			@tag = @image.tags.new(:name => "abcd")
			@tag.save
			@image.destroy
			Tag.all.should_not include(@tag)
		end
	end
end

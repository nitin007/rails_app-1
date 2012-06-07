class Tag < ActiveRecord::Base
	attr_accessible :name
	
  # OPTIMIZE: WA: This is a bad choice of tag storage policy.
  # For two different images with same tag name, a tag will
  # be created twice. Moreover, if one wants to find images
  # with certaing tag name, you will have to first collect
  # image_id of tag with specific name and then find
  # corresponding images. You can not do:
  #
  # >> tag = Tag.where(:name => "vacation").first
  # >> tag.images
  #

  belongs_to :image
end

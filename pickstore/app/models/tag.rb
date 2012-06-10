class Tag < ActiveRecord::Base
	attr_accessible :name
	
	#Fixed: NG
  # QUESTION: WA: If your application were in production and
  # user had created tags for images with previous implementation,
  # how would have you ported those tags to current implementation.
  # Answer below with other fixes.
  has_and_belongs_to_many :images
end

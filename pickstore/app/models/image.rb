class Image < ActiveRecord::Base  
  attr_accessible :picture_content_type, :picture_file_name, :picture_file_size, :title, :album_id, :picture, :tags_attributes

  belongs_to :album
  has_many :tags, :dependent => :destroy
  
  has_attached_file :picture, :styles => {:thumb => "100*100#", :small => "150*150>"}, 
  		:path => ":rails_root/public/system/:attachment/:id/:style/:filename", :url => "/system/:attachment/:id/:style/:filename",
  		:whiny_thumbnails => true
  		
  validates :title, :presence => true
  # FIXME: WA: Following should also include validations for
  # size and type of the file being uploaded. A user can
  # upload an avi file of 4GiB
  validates_attachment_presence :picture
  
  accepts_nested_attributes_for :tags, 
    # FIXME: WA: Shouldn't following proc use any? instead
    # of all?. Attributes should be rejected if any of the
    # tags being submitted is blank. Infact one should
    # reject only blank tags and proceed with the creation
    # of others.
  :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }, :allow_destroy => true
end

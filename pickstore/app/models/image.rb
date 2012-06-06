class Image < ActiveRecord::Base  
  attr_accessible :picture_content_type, :picture_file_name, :picture_file_size, :title, :album_id, :picture, :tags_attributes

  belongs_to :album
  has_many :tags, :dependent => :destroy
  
  has_attached_file :picture, :styles => {:thumb => "100*100#", :small => "150*150>"}, 
  		:path => ":rails_root/public/system/:attachment/:id/:style/:filename", :url => "/system/:attachment/:id/:style/:filename",
  		:whiny_thumbnails => true
  		
  validates :title, :presence => true
  validates_attachment_presence :picture
  
  accepts_nested_attributes_for :tags, 
  :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }, :allow_destroy => true
end

class Image < ActiveRecord::Base  
  attr_accessible :picture_content_type, :picture_file_name, :picture_file_size, :title, :album_id, :picture, :tags_attributes

  belongs_to :album
  
  has_and_belongs_to_many :tags
      
  has_attached_file :picture, :styles => {:thumb => "100*100#", :small => "150*150>"}, 
  		:path => ":rails_root/public/system/:attachment/:id/:style/:filename", :url => "/system/:attachment/:id/:style/:filename",
  		:whiny_thumbnails => true
  		
  validates :title, :presence => true
  
  #Fixed: NG
  validates_format_of :picture_file_name, :with => %r{\.(jpeg|gif)$}i
  validates_attachment_size :picture, :less_than => 1.megabytes
  validates_attachment_presence :picture
  
  accepts_nested_attributes_for :tags, 
  :reject_if => proc { |attrs| attrs['name'].blank? }, :allow_destroy => true
end

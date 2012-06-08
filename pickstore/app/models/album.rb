class Album < ActiveRecord::Base
  attr_accessible :name, :user_id, :images_attributes, :tags_attributes
  
  belongs_to :user
  has_many :images, :dependent => :destroy
  
  validates :name, :presence => true
  
  accepts_nested_attributes_for :images, 
  :reject_if => proc { |attrs| attrs['title'].blank? }, :allow_destroy => true
end


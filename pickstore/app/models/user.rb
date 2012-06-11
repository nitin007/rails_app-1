class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation
  
	# Fixed: NG
	has_secure_password
  validates :username, :presence => true, :uniqueness => true
  
  #Fixed: NG
  validates :password, :length => {:minimum => 5}
	  										 
  has_many :albums
 end

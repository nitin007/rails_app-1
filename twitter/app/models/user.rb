class User < ActiveRecord::Base
  attr_accessible :email, :fullname, :password, :password_digest, :username, :password_confirmation
  
  validates :fullname, :presence => true
  validates :email, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 8}
  
  has_many :tweets
  
  has_secure_password
end

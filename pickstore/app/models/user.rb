require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation
  
  # TODO: WA: Since Rails 3.0.1 ActiveRecord includes
  # ActiveModel::SecurePassword which provides a
  # has_secure_password method. Why re-invent the
  # wheel. Lets use that.
  before_create :hash_password
  
  validates :username, :presence => true, :uniqueness => true
  # TODO: WA: Do we need a presence validation when
  # we have specified minimum length to be greater
  # than zero?
  validates :password, :presence => true, 
  										 :length => {:minimum => 5}, 
  										 :confirmation => true
	  										 
  has_many :albums
  
  def self.authenticate(username, password)
  	User.find(:first, :conditions => ["username = ? and password = ?", username, Digest::SHA512.hexdigest(password)]) 
  end
  
  def hash_password
  	self.password = Digest::SHA512.hexdigest(self.password)
  end
end

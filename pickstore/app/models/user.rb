class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation
  
  # TODO: WA: Since Rails 3.0.1 ActiveRecord includes
  # ActiveModel::SecurePassword which provides a
  # has_secure_password method. Why re-invent the
  # wheel. Lets use that.

	# Fixed: NG
	has_secure_password
  validates :username, :presence => true, :uniqueness => true
  
  # TODO: WA: Do we need a presence validation when
  # we have specified minimum length to be greater
  # than zero?
  
  #Fixed: NG
  validates :password, :length => {:minimum => 5}
	  										 
  has_many :albums
 end

class Tweet < ActiveRecord::Base
  attr_accessible :message, :type, :user_id
  
  belongs_to :user
end

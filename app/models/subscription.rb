class Subscription < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id', :conditions => ["users.status = 1"]
  
  validates :user_id, :follower_id, :presence => true
  validates :user_id, :uniqueness => {:scope => [:follower_id]}
end
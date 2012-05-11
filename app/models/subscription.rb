# == Schema Information
#
# Table name: subscriptions
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)      not null
#  follower_id :integer(4)      not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  status      :integer(4)      default(1), not null
#

class Subscription < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id', :conditions => ["users.status = 1"]
  
  validates :user_id, :follower_id, :presence => true
  validates :user_id, :uniqueness => {:scope => [:follower_id]}
end

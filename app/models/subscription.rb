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

  belongs_to :user, :conditions => ["users.status = 1"], :counter_cache => :count_of_followers
  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id', :conditions => ["users.status = 1"]

  validates :user_id, :follower_id, :presence => true
  validates :user_id, :uniqueness => {:scope => [:follower_id]}

  after_create :notify_user

  def notify_user
    user, follower = User.find(user_id), User.find(follower_id)
    UserMailer.follower_notification(user, follower).deliver
  end
end

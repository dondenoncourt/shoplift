class Subscription < ActiveRecord::Base
  belongs_to :user, :conditions => ["users.status = 1"],
                    :counter_cache => :count_of_followers

  belongs_to :follower, :class_name  => 'User',
                        :foreign_key => 'follower_id',
                        :conditions  => ["users.status = 1"]

  has_many :user_item_views, :foreign_key => :user_id,
                             :primary_key => :follower_id

  validates :user_id, :follower_id, :presence => true
  validates :user_id, :uniqueness => {:scope => [:follower_id]}

  after_create :notify_user

  def notify_user
    user, follower = User.find(user_id), User.find(follower_id)
    UserMailer.follower_notification(user, follower).deliver
  end
end

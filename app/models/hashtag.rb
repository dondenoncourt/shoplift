class Hashtag < ActiveRecord::Base
  belongs_to :hashtag_value, :counter_cache => true
  belongs_to :post, :conditions => ['posts.status = 1']
  belongs_to :user, :conditions => ['users.status = 1'], :counter_cache => :count_of_hashtags

  has_many :hashtag_flags, :conditions => ["hashtag_flags.status = 1"]

  validates :hashtag_value_id, :post_id, :user_id, :presence => true
  validates :hashtag_value_id, :uniqueness => {:scope => [:post_id, :user_id]}

  def items
    Item.where("post_id = ?", post_id)
  end
end

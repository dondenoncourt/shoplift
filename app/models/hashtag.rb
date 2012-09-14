# == Schema Information
#
# Table name: hashtags
#c
#  id               :integer(4)      not null, primary key
#  hashtag_value_id :integer(4)      not null
#  post_id          :integer(4)      not null
#  user_id          :integer(4)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  status           :integer(4)      default(1), not null
#

class Hashtag < ActiveRecord::Base
  require 'status'

  belongs_to :hashtag_value
  belongs_to :post, :conditions => ['posts.status = 1']
  belongs_to :user, :conditions => ['users.status = 1'], :counter_cache => :count_of_hashtags

  has_many :hashtag_flags, :conditions => ["hashtag_flags.status = 1"]
  validates :hashtag_value_id, :post_id, :user_id, :presence => true
  validates :hashtag_value_id, :uniqueness => {:scope => [:post_id, :user_id]}

  def items
    Item.where("post_id = ?", post_id)
  end
end

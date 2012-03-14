class Hashtag < ActiveRecord::Base
  require 'status'
  
  belongs_to :hashtag_value
  belongs_to :post, :conditions => ['posts.status = 1']
  belongs_to :user, :conditions => ['users.status = 1']
  has_many :hashtag_flags, :conditions => ["hashtag_flags.status = 1"]
  
  validates :hashtag_value_id, :post_id, :user_id, :presence => true
  validates :hashtag_value_id, :uniqueness => {:scope => [:post_id, :user_id]}
end
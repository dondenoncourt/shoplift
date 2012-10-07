class HashtagFlag < ActiveRecord::Base
  belongs_to :flag_type
  belongs_to :hashtag, :conditions => ["hashtags.status = 1"]
  belongs_to :user, :conditions => ["users.status = 1"]

  has_one :post, :through => :hashtag, :conditions => ["posts.status = 1"]
  has_many :items, :through => :post, :conditions => ["items.status = 1"]

  validates :flag_type_id, :hashtag_id, :user_id, :presence => true
  validates :flag_type_id, :uniqueness => {:scope => [:hashtag_id, :user_id]}
end

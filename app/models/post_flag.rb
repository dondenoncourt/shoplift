class PostFlag < ActiveRecord::Base
  belongs_to :flag_type
  belongs_to :post, :conditions => ["posts.status = 1"]
  belongs_to :user, :conditions => ["users.status = 1"]
  has_one :items, :through => :post, :conditions => ["items.status = 1"]

  validates :flag_type_id, :post_id, :user_id, :presence => true
  validates :flag_type_id, :uniqueness => {:scope => [:post_id, :user_id]}
end

class Item < ActiveRecord::Base
  require 'status'
  
  belongs_to :post, :conditions => ["posts.status = 1"]
  has_one :user, :through => :post, :conditions => ["users.status = 1"]
  belongs_to :user, :conditions => ["users.status = 1"]
  has_many :hashtags, :through => :post, :conditions => ["hashtags.status = 1"]
  has_many :hashtag_values, :through => :hashtags
  has_many :suggestions
  has_many :set_asides
  belongs_to :parent, :class_name => "Item", :foreign_key => "parent_id", :conditions => ["items.status = 1"]
  
  validates :user_id, :post_id, :presence => true
  validates :post_id, :uniqueness => {:scope => [:user_id]}
end
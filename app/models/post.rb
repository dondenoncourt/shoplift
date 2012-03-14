class Post < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
  has_many :hashtags, :conditions => ["hashtags.status = 1"]
  has_many :items, :conditions => ["items.status = 1"]
  has_many :post_flags, :conditions => ["post_flags.status = 1"]
  
  validates :name, :brand, :url, :retailer, :user_id, :presence => true
  
  define_index do
    indexes name, :sortable => true
  end
    
end
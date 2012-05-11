# == Schema Information
#
# Table name: hashtag_flags
#
#  id           :integer(4)      not null, primary key
#  flag_type_id :integer(4)      not null
#  hashtag_id   :integer(4)      not null
#  user_id      :integer(4)      not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  status       :integer(4)      default(1), not null
#

class HashtagFlag < ActiveRecord::Base
  require 'status'
  
  belongs_to :flag_type
  belongs_to :hashtag, :conditions => ["hashtags.status = 1"]
  belongs_to :user, :conditions => ["users.status = 1"]
  has_one :post, :through => :hashtag, :conditions => ["posts.status = 1"]
  has_one :items, :through => :post, :conditions => ["items.status = 1"]
  
  validates :flag_type_id, :hashtag_id, :user_id, :presence => true
  validates :flag_type_id, :uniqueness => {:scope => [:hashtag_id, :user_id]}
end

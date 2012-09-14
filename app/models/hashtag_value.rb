# == Schema Information
#
# Table name: hashtag_values
#
#  id         :integer(4)      not null, primary key
#  value      :string(60)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class HashtagValue < ActiveRecord::Base
  has_many :hashtags
  has_many :category_hashtag_values
  has_many :categories, :through => :category_hashtag_values
  has_many :posts, :through => :hashtags
  has_many :items, :through => :posts
  has_many :users, :through => :items
  has_many :hashtagbrands, :dependent => :delete_all

  after_create {|h| Hashtagbrand.create(:hashtag => h)}

end

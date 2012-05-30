class Category < ActiveRecord::Base
  has_many :category_hashtag_values
  has_many :hashtag_values, :through => :category_hashtag_values

  has_many :hashtags, :through => :hashtag_values
  has_many :posts, :through => :hashtags
  has_many :items, :through => :posts
end

class Category < ActiveRecord::Base
  has_many :category_hashtag_values
  has_many :hashtag_values, :through => :category_hashtag_values

  has_many :hashtags, :through => :hashtag_values
  has_many :posts, :through => :hashtags
  has_many :items, :through => :posts
end
# == Schema Information
#
# Table name: categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  param      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#


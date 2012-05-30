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
end

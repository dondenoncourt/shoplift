class CategoryHashtagValue < ActiveRecord::Base
  belongs_to :category
  belongs_to :hashtag_value
end
# == Schema Information
#
# Table name: category_hashtag_values
#
#  id               :integer(4)      not null, primary key
#  category_id      :integer(4)
#  hashtag_value_id :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#


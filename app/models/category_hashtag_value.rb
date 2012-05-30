class CategoryHashtagValue < ActiveRecord::Base
  belongs_to :category
  belongs_to :hashtag_value
end

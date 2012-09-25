# == Schema Information
#
# Table name: hashtagbrands
#
#  id               :integer(4)      not null, primary key
#  brand_id         :integer(4)
#  hashtag_value_id :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#
class Hashtagbrand < ActiveRecord::Base
  belongs_to :hashtag_value
  belongs_to :brand
  def items
    if brand
      brand.items
    else
      hashtag_value.items
    end
  end
  def value
    if brand
      brand.name
    else
      hashtag_value.value
    end
  end
  def image
    if brand
      brand.items.last.post.photo if brand.items
    else
      hashtag_value.hashtags.first.post.photo if hashtag_value.hashtags.first
    end
  end
  def users
    if brand
      brand.users
    else
      hashtag_value.users
    end
  end
  def related(limit)
    if brand
      brand.related_hashtagbrands(limit)
    else
      hashtag_value.related_hashtagbrands(limit)
    end
  end
end


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
end

class Hashtagbrand < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :brand
  def items
    if brand
      brand.items
    else
      hashtag.items
    end
  end
  def value
    if brand
      brand.name
    else
      hashtag.hashtag_value.value
    end
  end
  def image
    if brand
      brand.items.last.post.photo
    else
      hashtag.post.photo
    end
  end
end

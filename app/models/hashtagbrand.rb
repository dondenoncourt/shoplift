class Hashtagbrand < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :brand
end

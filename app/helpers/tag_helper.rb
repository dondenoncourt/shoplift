module TagHelper

  def image_and_value(tag)
    image_tag(tag.user.avatar.url(:tiny), size: '20x20') + ' ' + tag.hashtag_value.value
  end

end

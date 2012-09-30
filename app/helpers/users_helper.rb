module UsersHelper
  def sex_to_string(user)
    user.sex = user.sex ? 'Male' : 'Female'
  end

  def user_image_and_value(user, value)
    image_tag(user.avatar.url(:tiny), size: '20x20') + ' ' + value
  end

  def min_name(name, min=32)
    if name.size < min
      return name
    end
    name[0..(min)]+'... '
  end

end

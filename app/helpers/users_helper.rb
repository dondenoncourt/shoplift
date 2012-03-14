module UsersHelper
  def sex_to_string(user)
    user.sex = user.sex ? 'Male' : 'Female' 
  end
end
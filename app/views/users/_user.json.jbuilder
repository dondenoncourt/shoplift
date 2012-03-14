json.extract(user, :id, :email, :username, :full_name)
json.sex sex_to_string(user)

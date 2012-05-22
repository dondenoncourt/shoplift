json.extract(user, :id, :email, :username, :full_name, :first_name, :last_name, :vanity_url, :country, :biography, :notify_new_follower, :notify_relift, :notify_missing, :hometown, :zipcode, :sex)
json.sex sex_to_string(user)
json.avatar_url_small user.avatar(:small)
json.avatar_url_thumb user.avatar(:thumb)

json.user do |json|
  json.id user.id
  json.email user.email
  json.username user.username
  json.full_name user.full_name
  json.first_name user.first_name
  json.last_name user.last_name
  json.url user.url
  json.vanity_url user.vanity_url
  json.country user.country
  json.biography user.biography
  json.notify_new_follower user.notify_new_follower
  json.notify_relift user.notify_relift
  json.notify_missing user.notify_missing
  json.hometown user.hometown
  json.zipcode user.zipcode
  json.sex sex_to_string(user)
  json.avatar_url_small user.avatar(:small)
  json.avatar_url_thumb user.avatar(:thumb)
  json.followee_count current_user.followees.count if user_signed_in?
  json.followee_ids Subscription.where("user_id = ?", user.id).pluck(:follower_id)
  json.follower_ids Subscription.where("follower_id = ?", user.id).pluck(:user_id)
  json.hashtagbrand_ids user.hashtagbrands.pluck(:id)
end

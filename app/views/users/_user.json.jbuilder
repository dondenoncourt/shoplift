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
  json.description user.biography
  json.notify_new_follower user.notify_new_follower
  json.notify_relift user.notify_relift
  json.notify_missing user.notify_missing
  json.hometown user.hometown
  json.zipcode user.zipcode
  json.sex sex_to_string(user)
  json.avatar user.avatar(:small)
  json.avatar_url_thumb user.avatar(:thumb)
  json.followee_count current_user.followees.count if user_signed_in?
  json.followee_ids user.followees.pluck('subscriptions.user_id')
  json.follower_ids user.followers.pluck('subscriptions.follower_id')
  json.item_ids user.items.pluck('items.id')
  json.hashtagbrand_ids ((user.hashtagbrands)?user.hashtagbrands.pluck(:id):'[]')
end

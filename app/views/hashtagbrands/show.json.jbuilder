json.hashtagbrand do |json|
  json.id @hashtagbrand.id
  json.value @hashtagbrand.value
  json.image @hashtagbrand.image.url(:small)
  json.item_ids @hashtagbrand.items.pluck('items.id')
  json.user_ids @hashtagbrand.users.pluck('users.id')
end

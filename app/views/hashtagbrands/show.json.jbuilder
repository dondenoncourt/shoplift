json.hashtagbrand do |json|
  json.id @hashtagbrand.id
  json.value @hashtagbrand.value
  json.image @hashtagbrand.image.url(:small)
  json.item_ids @hashtagbrand.items.pluck(:id)
  json.user_ids  [1, 2, 3]
end

json.id item.id
json.name item.post.name
json.brand do |json|
  json.id item.post.brand.hashtagbrand.id
  json.value item.post.brand.name
end
json.url item.post.url
json.price item.post.price
json.comment item.post.comment
json.photo_file_name item.post.photo.url(:small)
json.user_id item.user_id

item.set_asides.each do |set_aside|
  if current_user && set_aside.user_id == current_user.id 
    json.set_aside set_aside
  end
end

if item.post.hashtags_allowed
  json.hashtag_ids item.hashtagbrands_hashtags.pluck('hashtagbrands.id')
else
  json.hashtag_ids '[]'
end

json.history do |json|
 json.partial! 'items/history', :@post => item.post
end

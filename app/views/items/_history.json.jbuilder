json.id @post.id
json.items_count @post.items.size
json.items @post.items.sort do |json, item|
  json.id item.id
  json.created_at item.created_at
	json.user do |json|
    if item.user
      json.id item.user.id
      json.full_name item.user.full_name
      json.thumb_url item.user.thumb_url
      json.full_name item.user.full_name
			#json.partial! item.user    user this should we want to list more user info
    end
  end
end
json.first_lifter do |json|
  json.created_at @post.created_at
  if @post.user
    json.id @post.user.id
    json.full_name @post.user.full_name
    json.thumb_url @post.user.thumb_url
  end
end

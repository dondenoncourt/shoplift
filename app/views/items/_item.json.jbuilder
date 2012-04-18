json.id item.id
json.name item.post.name
json.description item.post.description
json.brand item.post.brand
json.retailer item.post.retailer
json.url item.post.url
json.price item.post.price
json.comment item.post.comment
json.hashtags_allowed item.post.hashtags_allowed
json.created_at item.post.created_at
if item.post.hashtags_allowed
	json.hashtags item.post.hashtags do |json, hashtag|
		json.id hashtag.id
		json.value hashtag.hashtag_value.value
	end
else
	json.hashtags "Hashtags not allowed"
end

# Check if item is a relift
if item.parent_id.blank?
	json.user do |json|
		json.partial! item.user
	end
else
	json.relift do |json|
		json.created_at item.created_at
		json.user do |json|
			json.partial! item.post.user
		end
	end
	json.user do |json|
		json.partial! item.user
	end
end

json.flag_total item.post.post_flags.count
json.flags item.post.post_flags do |json, flag|
	json.flag_type flag.flag_type.name
end
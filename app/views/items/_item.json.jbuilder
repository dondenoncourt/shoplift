json.id item.id
# json.parent_id item.parent_id
json.name item.post.name
# json.description item.post.description
json.brand item.post.brand.name
# json.retailer item.post.retailer
json.url item.post.url
json.price item.post.price
json.comment item.post.comment
json.photo_file_name item.post.photo.url(:small)
# json.hashtags_allowed item.post.hashtags_allowed
# json.created_at item.post.created_at
json.user_id item.user_id

item.set_asides.each do |set_aside|
  if current_user && set_aside.user_id == current_user.id 
    json.set_aside set_aside
  end
end

if item.post.hashtags_allowed
  json.hashtagbrand_ids item.hashtagbrands_hashtags.pluck('hashtagbrands.id')
else
  json.hashtagbrand_ids '[]'
end

# Check if item is a relift
# if item.parent_id.blank?
#	json.user do |json|
#    json.partial! item.user if item.user
#	end
# else
#	json.relift do |json|
#		json.created_at item.created_at
#		json.user do |json|
#			json.partial! item.post.user
#		end
#	end
#	json.user do |json|
#		json.partial! item.user
#	end
# end

# json.flag_total item.post.post_flags.count
# json.flags item.post.post_flags do |json, flag|
#	json.flag_type flag.flag_type.name
# end

# json.history do |json|
#  json.partial! 'items/history', :@post => item.post
# end

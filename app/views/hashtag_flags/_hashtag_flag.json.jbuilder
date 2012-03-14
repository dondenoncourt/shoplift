json.id hashtag_flag.id
json.flag_type hashtag_flag.flag_type.name
json.hashtag_value hashtag_flag.hashtag.hashtag_value.value
json.item do |json|
	json.partial! hashtag_flag.items
end

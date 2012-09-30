json.id post_flag.id
json.flag_type post_flag.flag_type.name
json.item do |json|
	json.partial! post_flag.items
end

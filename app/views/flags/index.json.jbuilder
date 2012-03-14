json.flags @post_flags do |json,post_flag|
	json.partial! post_flag
end

json.flags @hashtag_flags do |json,hashtag_flag|
	json.partial! hashtag_flag
end
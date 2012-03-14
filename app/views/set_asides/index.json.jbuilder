json.set_asides @set_asides do |json,set_aside|
	json.partial! set_aside.item
end
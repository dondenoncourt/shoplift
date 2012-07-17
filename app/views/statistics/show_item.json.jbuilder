json.item do |json|
	json.partial! @item
end
json.statistics do |json|
	json.views @item.views
	json.visits @item.visits
	json.relifts @item.visits
	
	if @item.parent_id.blank?
		json.total_views @item.post.views
		json.total_visits @item.post.visits
		json.total_relifts @item.post.relifts
	end
end
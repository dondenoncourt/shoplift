item_count = @items.count
json.total_items item_count

@total_views = @total_visits = @total_relifts = 0
@items.each do |item|
	@total_views = @total_views + item.views
	@total_visits = @total_visits + item.visits
	@total_relifts = @total_relifts + item.relifts 
end

json.total_views @total_views
json.total_visits @total_visits
json.total_relifts @total_relifts
if @total_views != 0
	json.average_views_per_item item_count/@total_views
else
	json.average_views_per_item 0
end
if @total_visits != 0
	json.average_visits_per_item item_count/@total_visits
else
	json.average_visits_per_item 0
end
if @total_relifts != 0
	json.average_relifts_per_item item_count/@total_relifts
else
	json.average_relifts_per_item 0
end
json.id @hashtagbrand.id
json.value @hashtagbrand.value
json.image (@hashtagbrand.image)?@hashtagbrand.image.url(:small):nil
json.item_ids (@hashtagbrand.items)?@hashtagbrand.items.pluck('items.id'):'[]'
json.user_ids @hashtagbrand.users.pluck('users.id')

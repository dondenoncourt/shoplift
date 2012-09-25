Shoplift.Hashtagbrand = DS.Model.extend({
	value: DS.attr('string'),
	image: DS.attr('string'),
	items: DS.hasMany('Shoplift.Item', { key: 'item_ids' }),
	users: DS.hasMany('Shoplift.User', { key: 'user_ids' }),
	related: DS.hasMany('Shoplift.Hashtagbrand', { key: 'related_ids' })
});
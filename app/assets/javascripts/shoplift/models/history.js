Shoplift.History = DS.Model.extend({
	firstLifter: DS.belongsTo('Shoplift.Relifter', {embedded: true}),
	items: DS.hasMany('Shoplift.Relift', {embedded: true}),
	itemsCount: DS.attr('number')
});
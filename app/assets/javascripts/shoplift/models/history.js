Shoplift.History = DS.Model.extend({
	firstLifter: DS.belongsTo('Shoplift.Relifter', {embedded: true}),
	relifts: DS.hasMany('Shoplift.Relift', {embedded: true, key: 'items'}),
	itemsCount: DS.attr('number')
});
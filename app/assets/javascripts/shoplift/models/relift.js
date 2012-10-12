Shoplift.Relift = DS.Model.extend({
	relifter: DS.belongsTo('Shoplift.Relifter', {embedded: true, key: 'user'})
})
Shoplift.Relift = DS.Model.extend({
	user: DS.belongsTo('Shoplift.Relifter', {embedded: true})
})
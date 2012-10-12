Shoplift.Relifter = DS.Model.extend({
	fullName: DS.attr('string'),
	thumbUrl: DS.attr('string', { defaultValue: '/assets/avatars/small/missing.png' })
});
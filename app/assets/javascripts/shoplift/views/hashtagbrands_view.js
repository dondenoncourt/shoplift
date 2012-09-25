
Shoplift.HashtagbrandView = Ember.View.extend({
	templateName: 'shoplift/templates/hashtagbrand',
	tagName: 'span',
	//classNames: ['tag-brand', 'item']
	isEven: function() {
		return this.get("controller").isEven();
	}.property()
})
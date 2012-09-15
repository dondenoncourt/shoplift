
Shoplift.HashtagbrandView = Ember.View.extend({
	templateName: 'hashtagbrand',
	tagName: 'span',
	//classNames: ['tag-brand', 'item']
	isEven: function() {
		return this.get("controller").isEven();
	}.property()
})
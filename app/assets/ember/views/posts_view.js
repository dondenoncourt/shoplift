Shoplift.PostsView = Ember.View.extend({
	templateName: 'posts',
	tabPane: true,
	tagPane: false,
	quotePane: true,
	historyPane: false,
	showTags: function(event) {
		console.log("rape");
		this.set('quotePane', false);
		this.set('historyPane', false);
		this.set('tagPane', true);
	}
});
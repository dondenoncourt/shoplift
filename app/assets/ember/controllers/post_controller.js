Shoplift.PostController = Ember.ObjectController.extend({
	
});

Shoplift.PostCreateController = Ember.ObjectController.extend({
	submitForm: function(event) {
		//create a new post
		Shoplift.Post.createRecord(this.get("content"))
	}
});
Shoplift.UsersController = Ember.ArrayController.extend();


Shoplift.UserController = Ember.ObjectController.extend();

Shoplift.UserItemsController = Ember.ArrayController.extend({
	//content: router.get("userController").get("items")
});

Shoplift.UserFolloweesController = Ember.ArrayController.extend();

Shoplift.UserFollowersController = Ember.ArrayController.extend();

Shoplift.UserHashtagbrandsController = Ember.ArrayController.extend({
	
	isEven: function() {
		this.toggleProperty('even');
		console.log(this.get('even'));
		return this.get('even');
	}
});
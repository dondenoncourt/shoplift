Shoplift.UserController = Ember.ObjectController.extend({
	itemsClasses: 'profile-count of-items',
	followeesClasses: 'profile-count of-followees',
	followersClasses: 'profile-count of-followers',
	tagsBrandsClasses: 'tags-brands'
});

Shoplift.UserItemsController = Ember.ArrayController.extend({
	//content: router.get("userController").get("items")
});

Shoplift.UsersController = Ember.ArrayController.extend({
	
});

Shoplift.UserFolloweesController = Shoplift.UsersController.extend({
	
});

Shoplift.UserFollowersController = Ember.ArrayController.extend();

Shoplift.UserHashtagbrandsController = Ember.ArrayController.extend({
	
	isEven: function() {
		this.toggleProperty('even');
		console.log(this.get('even'));
		return this.get('even');
	}
});
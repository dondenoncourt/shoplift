Shoplift.UsersController = Ember.ArrayController.extend();


Shoplift.UserController = Ember.ObjectController.extend({
	itemsClasses: 'profile-count of-items',
	followeesClasses: 'profile-count of-followees',
	followersClasses: 'profile-count of-followers',
	tagsBrangsClasses: 'tags-brands'
});

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
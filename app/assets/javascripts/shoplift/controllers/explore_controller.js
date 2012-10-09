Shoplift.RecommendedController = Ember.ArrayController.extend({
	marginLeft: '305px',
	sortProperties: ['countOfPosts'],
	sortAscending: false
	//content: router.get("exploreSidebarController").get("content").get("recommended");
});

Shoplift.PopularController = Ember.ArrayController.extend();

Shoplift.NearbyController = Ember.ArrayController.extend();

Shoplift.FriendsController = Ember.ArrayController.extend();

Shoplift.InterestsController = Ember.ArrayController.extend();
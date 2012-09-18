Shoplift.ProfileSidebarController = Ember.Controller.extend();

Shoplift.HashtagbrandSidebarController = Ember.Controller.extend();

Shoplift.ExploreSidebarController = Ember.Controller.extend({
	content: Shoplift.store.find(Shoplift.User, "2")
});
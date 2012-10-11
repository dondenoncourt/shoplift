Shoplift.ProfileSidebarController = Ember.Controller.extend();

Shoplift.HashtagbrandSidebarController = Ember.Controller.extend();

Shoplift.ExploreSidebarController = Ember.Controller.extend({
	contentBinding: Ember.Binding.oneWay('currentUserController.content')
});
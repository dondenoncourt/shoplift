Shoplift.VanityRoute = Ember.Route.extend({
	route: '!/:vanity',
	deserialize: function(params) {
		return Shoplift.store.find(Shoplift.User).where({"vanity_url": params.vanity});
	},	
	connectOutlets: function(router, context) {
		//router.transitionTo('user.index', context);
		router.get("applicationController").connectOutlet('carousel', 'user', context);
	},
	index: Ember.Route.extend({
		route: '/'
	})
});
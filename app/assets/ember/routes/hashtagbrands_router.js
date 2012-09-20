Shoplift.HashtagbrandRoute = Ember.Route.extend({
  route: '/hashtagbrands/:hashtagbrand_id',
  showTag: Ember.Route.transitionTo('hashtagbrand.index'),
  showItems: Ember.Route.transitionTo('items'),
  showMembers: Ember.Route.transitionTo('members'),
  connectOutlets: function(router, hashtagbrand) {
  	console.dir(hashtagbrand);
  	//router.get("applicationController").connectOutlet('carousel', 'hashtagbrand', hashtagbrand);
	router.get("applicationController").connectOutlet({
	  viewClass: Shoplift.HashtagbrandSidebarView,
	  controller: router.get("hashtagbrandController"),
	  outletName: 'carousel',
	  context: hashtagbrand
	});
	router.get("applicationController").connectOutlet({
	  name: 'nav',
	  outletName: 'header'
	});
	router.get("navController").connectOutlet('logo');
  },
  index: Ember.Route.extend({
	  route: '/',
	  redirectsTo: 'items'
  }),
  items: Ember.Route.extend({
	  route: '/items',
	  connectOutlets: function(router) {
		  router.get("hashtagbrandController").connectOutlet({
			  viewClass: Shoplift.CarouselContainerView,
			  controller: router.get("hashtagbrandItemsController"),
			  context: router.get("hashtagbrandController").get("items")
		  });
	  }
  }),
  members: Ember.Route.extend({
	  route: '/members',
	  connectOutlets: function(router) {
	  	//console.log(router.get("hashtagbrandUsersContoroller"));
		  router.get("hashtagbrandController").connectOutlet({
			  viewClass: Shoplift.UserCarouselContainerView,
			  controller: router.get("hashtagbrandUsersController"),
			  context: router.get("hashtagbrandController").get("users")
		  });
	  }
  })
});
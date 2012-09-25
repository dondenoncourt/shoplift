Shoplift.SearchRoute = Ember.Route.extend({
  route: '/search/:query',
  showQuery: Ember.Route.transitionTo('search.index'),
  showItems: Ember.Route.transitionTo('items'),
  showMembers: Ember.Route.transitionTo('members'),
  serialize: function(router, context) {
	  return {
		  query: context
	  }
  },
  deserialize: function(router, params) {
	  return params.query; //this could actually be the entire search results object
  },
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
	  enter: function() {
		  router.get("hashtagbrandController").set("showItemsClasses", "show-items-on tag-type");
	  },
	  exit: function() {
		  router.get("hashtagbrandController").set("showItemsClasses", "show-items tag-type");
	  },
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
	  enter: function() {
	  	  router.get("hashtagbrandController").set("orMembersClasses", "or-members-on tag-type");
	  },
	  exit: function() {
	  	  router.get("hashtagbrandController").set("orMembersClasses", "or-members tag-type");
	  },
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
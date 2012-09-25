Shoplift.UsersRoute = Ember.Route.extend({
  route: '/users',
  /*showItems: Ember.Route.transitionTo("show.items"),
  showFollowees: Ember.Route.transitionTo("show.followees"),
  showFollowers: Ember.Route.transitionTo("show.followers"),
  showHashtags: Ember.Route.transitionTo("show.hashtags"),*/
  index: Ember.Route.extend({
	route: '/'
  }),
});


Shoplift.UserRoute = Ember.Route.extend({
  route: '/users/:user_id',
  showItems: Ember.Route.transitionTo("items"),
  showFollowees: Ember.Route.transitionTo("followees"),
  showFollowers: Ember.Route.transitionTo("followers"),
  showHashtagbrands: Ember.Route.transitionTo("hashtagbrands"),
  showHashtagbrand: Ember.Route.transitionTo("hashtagbrand.index"),
  /*serialize: function(router, context){
	return {id: context.get('id')};
  },
  deserialize: function(router, params){
	console.log(Shoplift.store.find(Shoplift.User, params.id));
	return Shoplift.store.find(Shoplift.User, params.id);
  },*/
  
  connectOutlets: function(router, user) {
	//if(typeof user !== "undefined" && user !== null) {
	//  user = Shoplift.User.find()
	//}
	if(!user) {
		  user = Shoplift.User.find(3);
	  }
	router.get("applicationController").connectOutlet({
	  viewClass: Shoplift.ProfileSidebarView,
	  controller: router.get("userController"),
	  outletName: 'carousel',
	  context: user
	}); 
	//console.dir(user.get("items"));
	router.get("applicationController").connectOutlet({
	  name: 'nav',
	  outletName: 'header'
	});
	router.get("navController").connectOutlet({
	  viewClass: Shoplift.FaceView,
	  controller: router.get("userController"),
	  context: user
	});
  },
  index: Ember.Route.extend({
	route: '/',
	redirectsTo: 'items'
  }),
  items: Ember.Route.extend({
	route: '/items',
	enter: function() {
		router.get("userController").set("itemsClasses", 'profile-count of-items-on');
	},
	exit: function() {
		router.get("userController").set("itemsClasses", 'profile-count of-items');
	},
	connectOutlets: function(router) {
	  router.get('itemsController').resetLoadMore();
	  
	  // set current query
	  var query = { user_id: router.get("userController").get("content").get("id"), isLoadedCallback: function() {
	    router.set('itemsController.isLoading', false);
	  }};
	  router.set('itemsController.query', query);
	  router.set('itemsController.isLoading', true);
	  
	  // get items shoplifted by user's followers
	  //var userItems = Shoplift.store.findQuery(Shoplift.Item, {page: 1});
	  
	  
	  // get all events for this repository
	  var filter = function(data) {
	    return true;
	  };
	  var userItems = Shoplift.store.filter(Shoplift.Item, query, filter);
	  
	  router.get('userController').connectOutlet('items', userItems);
	  
	  /*router.get("userController").connectOutlet({
		viewClass: Shoplift.ItemsView, //TODO: created extended version to handle lazy loading: Shoplift.UserItemCarouselContainerView,
		controller: router.get("userItemsController"),
		context: router.get("userController").get("content").get("items")
	  });*/
	  //router.get("userController").connectOutlet('carouselContainer');
	}
  }), //end users/show/items
  followees: Ember.Route.extend({
	route: '/followees',
	enter: function() {
		router.get("userController").set("followeesClasses", 'profile-count of-followees-on');
	},
	exit: function() {
		router.get("userController").set("followeesClasses", 'profile-count of-followees');
	},
	connectOutlets: function(router) {
	  router.get("userController").connectOutlet({ 
		viewClass: Shoplift.UsersView,
		controller: router.get("userFolloweesController"),
		context: router.get("userController").get("content").get("followees")
	  });
	}
  }), //end users/show/followees
  followers: Ember.Route.extend({
	route: '/followers',
	enter: function() {
		router.get("userController").set("followersClasses", 'profile-count of-followers-on');
	},
	exit: function() {
		router.get("userController").set("followersClasses", 'profile-count of-followers');
	},
	connectOutlets: function(router) {
		//var context = router.get("userController").get("content").get("followers");
		Shoplift.User.find();
		var context = Shoplift.store.findMany(Shoplift.User, ["1","2","3","4"]);
		router.get("userController").connectOutlet('userCarouselContainer', context);
	  /*router.get("userController").connectOutlet({ 
		viewClass: Shoplift.UserCarouselContainerView,
		controller: router.get("userFollowersController"),
		context: router.get("userController").get("content").get("followers")
	  });*/
	}
  }), //end users/show/followers
  hashtagbrands: Ember.Route.extend({
	route: '/tags',
	enter: function() {
		router.get("userController").set("tagsBrandsClasses", 'tags-brands-on');
	},
	exit: function() {
		router.get("userController").set("tagsBrandsClasses", 'tags-brands');
	},
	connectOutlets: function(router) {
	  router.get("userController").connectOutlet({ 
		viewClass: Shoplift.HashtagbrandCarouselContainerView,
		controller: router.get("userHashtagbrandsController"),
		context: router.get("userController").get("content").get("hashtagbrands")
	  });
	}
  }) // end user/hashtags
});
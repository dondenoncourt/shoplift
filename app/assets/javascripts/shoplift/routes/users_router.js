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
  
  connectOutlets: function(router, user) {
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
			var itemsController = router.get('itemsController'),
					userController = router.get('userController'),
					marginLeft = userController.get('marginLeft');
			
			userController.set("itemsClasses", 'profile-count of-items-on');
			itemsController.set('marginLeft', marginLeft);
			itemsController.set('showFaces', false);
		},
		exit: function() {
			var itemsController = router.get('itemsController'),
					userController = router.get('userController');
			
			userController.set("itemsClasses", 'profile-count of-items');
			itemsController.set('marginLeft', '0px');
			itemsController.set('showFaces', true);
		},
		connectOutlets: function(router) {
			var itemsController = router.get('itemsController'),
					userController = router.get('userController');
					
		  itemsController.resetLoadMore();
	
		  // set current query
		  var query = { 
		  	user_id: userController.get("content.id"), 
		  	isLoadedCallback: function() {
		  		router.set('itemsController.isLoading', false);
		  	}
		  };
		  
		  itemsController.set('query', query);
		  itemsController.set('isLoading', true);
	
		  // get all events for this repository
		  var filter = function(data) {
		  	return true;
		  };
		  var userItems = Shoplift.store.filter(Shoplift.Item, query, filter);
	
		  userController.connectOutlet('items', userItems);
		  
		  
	
		  router.get("applicationController").connectOutlet({
		  	name: 'nav',
		  	outletName: 'header'
		  });

		  
		  /*router.get("userController").connectOutlet({ 
		  	viewClass: Shoplift.ItemsView,
		  	controller: router.get("itemsController"),
		  	context: router.get("userController").get("content").get("items")
		  });*/
		},
		loadMoreItems: function(router, page) {
			var query = router.get('itemsController.query');
			query.page = page;
			var results = Shoplift.store.findQuery(Shoplift.Item, query);
			router.set('itemsController.isLoading', true);
		},
  }), //end users/show/items
  followees: Ember.Route.extend({
		route: '/followees',
		enter: function() {
			var usersController = router.get('userFolloweesController'),
					userController = router.get('userController'),
					marginLeft = userController.get('marginLeft');
			
			userController.set("followeesClasses", 'profile-count of-followees-on');
			usersController.set('marginLeft', marginLeft);
		},
		exit: function() {
			var usersController = router.get('userFolloweesController'),
					userController = router.get('userController');
			
			userController.set("followeesClasses", 'profile-count of-followees');
			usersController.set('marginLeft', '0px');
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
			var usersController = router.get('userFollowersController'),
					userController = router.get('userController'),
					marginLeft = userController.get('marginLeft');
			
			userController.set("followersClasses", 'profile-count of-followers-on');
			usersController.set('marginLeft', marginLeft);
		},
		exit: function() {
			var usersController = router.get('userFollowersController'),
					userController = router.get('userController');
			
			userController.set("followersClasses", 'profile-count of-followers');
			usersController.set('marginLeft', '0px');
		},
		connectOutlets: function(router) {
			router.get("userController").connectOutlet({ 
				viewClass: Shoplift.UsersView,
				controller: router.get("userFollowersController"),
				context: router.get("userController").get("content").get("followers")
			});
		}
  }), //end users/show/followers
  hashtagbrands: Ember.Route.extend({
	route: '/tags',
	enter: function() {
		var tagsController = router.get('userHashtagbrandsController'),
				userController = router.get('userController'),
				marginLeft = userController.get('marginLeft');
		
		userController.set("tagsBrandsClasses", 'tags-brands-on');
		tagsController.set('marginLeft', marginLeft);
	},
	exit: function() {
		var tagsController = router.get('userHashtagbrandsController'),
				userController = router.get('userController');
		
		userController.set("tagsBrandsClasses", 'tags-brands');
		tagsController.set('marginLeft', '0px');
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
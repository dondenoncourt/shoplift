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
	router.get("applicationController").connectOutlet({
	  viewClass: Shoplift.ProfileSidebarView,
	  controller: router.get("userController"),
	  outletName: 'carousel',
	  context: user
	}); 
	//console.dir(user.get("items"));
	router.get("applicationController").connectOutlet({
	  viewClass: Shoplift.FaceView,
	  controller: router.get("userController"),
	  outletName: 'header',
	  context: user
	})
  },
  index: Ember.Route.extend({
	route: '/',
	redirectsTo: 'items'
  }),
  items: Ember.Route.extend({
	route: '/items',
	connectOutlets: function(router) {
	  /*Shoplift.store.load(Shoplift.Item, {
		id: 7,
		name: "Something 7",
		relifts: "5",
		brand: "Salvation Army",
		comment: "I love it",
		url: "http://google.com",
		price: "88",
		photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
		user_id: 2
	  });*/
	  router.get("userController").connectOutlet({
		viewClass: Shoplift.CarouselContainerView, //TODO: created extended version to handle lazy loading: Shoplift.UserItemCarouselContainerView,
		controller: router.get("userItemsController"),
		context: router.get("userController").get("content").get("items")
	  });
	  //router.get("userController").connectOutlet('carouselContainer');
	}
  }), //end users/show/items
  followees: Ember.Route.extend({
	route: '/followees',
	connectOutlets: function(router) {
	  router.get("userController").connectOutlet({ 
		viewClass: Shoplift.UserCarouselContainerView,
		controller: router.get("userFolloweesController"),
		context: router.get("userController").get("content").get("followees")
	  });
	}
  }), //end users/show/followees
  followers: Ember.Route.extend({
	route: '/followers',
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
	connectOutlets: function(router) {
	  router.get("userController").connectOutlet({ 
		viewClass: Shoplift.HashtagbrandCarouselContainerView,
		controller: router.get("userHashtagbrandsController"),
		context: router.get("userController").get("content").get("hashtagbrands")
	  });
	}
  }) // end user/hashtags
});
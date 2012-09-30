Shoplift.ItemsRoute = Ember.Route.extend({
  route: '/items',
  connectOutlets: function(router, items) {
  	router.get("navController.whoami");
  	setTimeout(function() {
	  	if(router.get("navController.currentUser.followees.length") < 2) {
		  	router.send("goExplore");
		  	console.log("not enough followers");
	  	}
	  	console.log("enough" + router.get("navController.currentUser.followees.length"));
  	}, 1000);
  	  
  	var store = router.get('store');
  	
  	router.get('itemsController').resetLoadMore();
  	
  	// set current query
  	var query = { isLoadedCallback: function() {
  	  router.set('itemsController.isLoading', false);
  	}};
  	router.set('itemsController.query', query);
  	router.set('itemsController.isLoading', true);
  	
  	var filter = function(data) {
  	  return true;
  	};
  	var userItems = Shoplift.store.filter(Shoplift.Item, query, filter);

  	router.get('applicationController').connectOutlet({
  		viewClass: Shoplift.ItemsView,
  		controller: router.get('itemsController'),
  		outletName: 'carousel', 
  		context: userItems
  	});
	
		
		
		router.get("navController").connectOutlet({
			name: 'logo',
			outletName: 'logo'
		});
  },
  index: Ember.Route.extend({
		route: '/'
  }),
  loadMoreItems: function(router, page) {
    var query = router.get('itemsController.query');
    query.page = page;
    var results = Shoplift.store.findQuery(Shoplift.Item, query);
    router.set('itemsController.isLoading', true);
  },
}); 


Shoplift.ItemRoute = Ember.Route.extend({
  route: '/items/:id',
  deserialize: function(router, params) {
	return Shoplift.Item.find(params.id);
  },
  connectOutlets: function(router, item) {
	router.get("applicationControler").connectOutlet("items", item);
  },
  index: Ember.Route.extend({
	route: '/'
	
  })
});
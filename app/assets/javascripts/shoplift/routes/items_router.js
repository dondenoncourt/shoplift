Shoplift.ItemsRoute = Ember.Route.extend({
  route: '/items',
  connectOutlets: function(router, items) {
  
  	var store = router.get('store');
  	
  	router.get('itemsController').resetLoadMore();
  	
  	// set current query
  	var query = { isLoadedCallback: function() {
  	  router.set('itemsController.isLoading', false);
  	}};
  	router.set('itemsController.query', query);
  	router.set('itemsController.isLoading', true);
  	
  	// get all events for this repository
  	var filter = function(data) {
  	  return true;
  	};
  	var userItems = Shoplift.store.filter(Shoplift.Item, query, filter);

  	router.get('applicationController').connectOutlet('carousel', 'items', userItems);
	
		router.get("applicationController").connectOutlet({
		  name: 'nav',
		  outletName: 'header'
		});
		
		router.get("navController").connectOutlet('logo');
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
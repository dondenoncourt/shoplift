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

  	// get items shoplifted by user's followers
  	//var userItems = Shoplift.store.findQuery(Shoplift.Item, {page: 1});
  	
  	
  	// get all events for this repository
  	var filter = function(data) {
  	  return true;
  	};
  	var userItems = Shoplift.store.filter(Shoplift.Item, query, filter);
  	
  	
  	
  	
  	router.get('applicationController').connectOutlet('carousel', 'items', userItems);
	
	//router.get('navController').set('target', Shoplift.NavManager);
	//console.log(router.get('navController'));
	router.get("applicationController").connectOutlet({
	  name: 'nav',
	  outletName: 'header'
	});
	router.get("navController").connectOutlet('logo');
	//console.dir(Shoplift.store.findMany(Shoplift.Item, [1,2,3,4]));
  },
  index: Ember.Route.extend({
	route: '/'
  }),
  loadMoreItems: function(router, page) {
    var query = router.get('itemsController.query');
    query.page = page;
    //router.get('store').findQuery(Shoplift.Item, query);
    var results = Shoplift.store.findQuery(Shoplift.Item, query);
    console.log(results);
    //Shoplift.store.find(Shoplift.Item);
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
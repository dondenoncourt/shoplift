Shoplift.ItemsRoute = Ember.Route.extend({
  route: '/items',
  connectOutlets: function(router, items) {
	Shoplift.Item.find();
	router.get("applicationController").connectOutlet({
	  name: 'carouselContainer',
	  outletName: 'carousel',
	  context: Shoplift.store.findMany(Shoplift.Item, ["1","2","3","4"])
	});
	router.get("applicationController").connectOutlet({
	  name: 'logo',
	  outletName: 'header'
	});
	//console.dir(Shoplift.store.findMany(Shoplift.Item, [1,2,3,4]));
  },
  index: Ember.Route.extend({
	route: '/'
  })
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
Shoplift.CarouselContainerController = Ember.ArrayController.extend({
  sortProperties: ['id'],
  goTo: function(id) {
	var lookup = [id-1,id,id+1,id+2];
	if(Shoplift.store.find(Shoplift.Item, id+2).get('isLoaded') === false) {
	  //lookup = [id-1, id, 1];
	  lookup = [id-2, id-1, id, id+1];
	}
	if(id-1 < 1 || Shoplift.store.find(Shoplift.Item, id-1).get('isLoaded') === false) {
	  lookup = [id, id+1, id+2, id+3];
	}
	this.set('content', Shoplift.store.findMany(Shoplift.Item, lookup));
  },
  next: function() {
	this.goTo(this.get('content').objectAt(2).get('id'));
  },
  prev: function() {
	this.goTo(this.get('content').objectAt(0).get('id'));
  }
});

Shoplift.UserCarouselContainerController = Ember.ArrayController.extend({
	sortProperties: ['id'],
	goTo: function(id) {
		var lookup = [id-1,id,id+1,id+2];
		if(Shoplift.store.find(Shoplift.User, id+2).get('isLoaded') === false) {
		  //lookup = [id-1, id, 1];
		  lookup = [id-2, id-1, id, id+1];
		}
		if(id-1 < 1 || Shoplift.store.find(Shoplift.User, id-1).get('isLoaded') === false) {
		  lookup = [id, id+1, id+2, id+3];
		}
		this.set('content', Shoplift.store.findMany(Shoplift.User, lookup));
	},
	next: function() {
		this.goTo(this.get('content').objectAt(2).get('id'));
	  },
	  prev: function() {
		this.goTo(this.get('content').objectAt(0).get('id'));
	  }
});
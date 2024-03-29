/* LoadMoreMixin and associated lazy-loading/infinite-scrolling code is taken from the open source project Github Dashboard 
https://github.com/pangratz/dashboard/commit/68d1728ec26dae5062eae5be43d61083cfc34f14
and this StackOverflow question: http://stackoverflow.com/questions/11907093/infinite-scroll-with-ember-js
Credit: @pangratz
*/

Shoplift.LoadMoreMixin = Ember.Mixin.create(Ember.Evented, {
  canLoadMore: true,
  autoFetch: true,
  currentPage: 1,
  isInViewCount: 0,
  threshold: 10,
  marginLeft: '0px',
  showFaces: true,
  loadMore: Ember.K,
  isLoading: false,
  
  resetLoadMore: function() {
		this.set('currentPage', 1);
  },

  thresholdIsMet: function() {
  	var threshold = this.get("threshold"),
  			isInViewCount = this.get("isInViewCount"),
  			length = this.get("length");

  	return (length - isInViewCount) < threshold;

  }.observes('threshold', 'isInViewCount', 'length'),

  canLoadMore: function() {
  	// can we load more entries? In this example only 10 pages are possible to fetch ...
  	return this.get('currentPage') < 10;
  }.property('currentPage'),

  shouldLoadMore: function() {
  		// if threshold met and can load more and is not loading more
  }.observes('thresholdIsMet', 'canLoadMore', 'isLoading'),

  loadMore: function() {
  	if (this.get('canLoadMore')) {
  		this.set('isLoading', true);
  		var page = this.incrementProperty('currentPage');

  		// findQuery triggers somehing like /events?page=6 and this
  		// will load more models of type App.Event into the store
  		//this.get('store').findQuery(Shoplift.Item, { page: page });

  		this.get('target').send('loadMoreItems', page);
  	} else {
  		this.set('isLoading', false);
  	}
  }
});

Shoplift.ItemsController = Ember.ArrayController.extend(Shoplift.LoadMoreMixin, {
  //sortProperties: ['id'],
  
});


Shoplift.UsersController = Ember.ArrayController.extend(Shoplift.LoadMoreMixin, {
  	currentPage: 1,

	canLoadMore: function() {
	  	// can we load more entries? In this example only 10 pages are possible to fetch ...
	  	return this.get('currentPage') < 10;
	}.property('currentPage'),

	loadMore: function() {
	  	if (this.get('canLoadMore')) {
	  	  	this.set('isLoading', true);
	  	  	var page = this.incrementProperty('currentPage');

	  	  	// findQuery triggers somehing like /events?page=6 and this
	  	  	// will load more models of type App.Event into the store
	  	  	//this.get('store').findQuery(Shoplift.Item, { page: page });

	  	  	this.get('target').send('loadMoreItems', page);
	  	} else {
				this.set('isLoading', false);
	  	}
	}
});



/*Shoplift.UserCarouselContainerController = Shoplift.CarouselContainerController.extend({
	sortProperties: ['id'],
	goTo: function(idString) {
		var id = parseInt(idString);
		console.log('user' + id);
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
});*/
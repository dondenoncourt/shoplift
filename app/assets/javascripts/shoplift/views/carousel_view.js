Shoplift.LoadMoreView = Ember.View.extend({
  templateName: 'shoplift/templates/load-more',
  classNames: ['load-more'],
  didInsertElement: function() {
		var view = this;
		this.$().bind('inview', function(event, isInView, visiblePartX, visiblePartY) {
		  if (isInView) {
		  	Ember.tryInvoke(view.get('controller'), 'loadMore');
		  }
		});
  }
});

Shoplift.ScrollableMixin = Ember.Mixin.create(Ember.Evented, {

  namespaceKeydown: function() {
  	  return "keydown." + this.get("elementId");
  }.property('elementId'),
  
  next: function() {
		$.scrollTo("+=" + this.get("scrollWidth"), 800, {axis: 'x'});
  },
  
  prev: function() {
  	$.scrollTo("-=" + this.get("scrollWidth"), 800, {axis: 'x'});
  },
  
  scrollableMixinDidInsert: function() {
		var that = this, 
		namespaceKeydown = this.get("namespaceKeydown"),
		time = 800,
		options = { axis: 'x' },
		KEY_RIGHT = 39,
		KEY_LEFT = 37;
		KEY_UP = 38;
		KEY_DOWN = 40;
	
		$(document).on(namespaceKeydown, function(e) {
		  if(e.which === KEY_RIGHT || e.which === KEY_LEFT || e.which === KEY_UP || e.which === KEY_DOWN) e.preventDefault();
		  
		  var scrollWidth = that.get("scrollWidth");
		  
		  if(e.which === KEY_RIGHT || e.which === KEY_DOWN) { 
				$.scrollTo("+=" + scrollWidth, time, options);
		  } else if(e.which === KEY_LEFT || e.which === KEY_UP) { 
				$.scrollTo("-=" + scrollWidth, time, options);
		  } else {
			  // noop
		  }
		});  
  },
  
  scrollableMixinWillRemove: function() {
		$(document).off("keydown");
  },
  
  didInsertElement: function() {
  	this.scrollableMixinDidInsert();
  },
  
  willDestroyElement: function() {
		this.scrollableMixinWillRemove();
  }

});

Shoplift.ItemsView = Ember.View.extend(Shoplift.ScrollableMixin, {
  elementId: 'carousel',
  templateName: 'shoplift/templates/items',
  scrollWidth: '434px',
  didInsertElement: function() {
	  this._super();
  },
  willDestroyElement: function() {
	  this._super();
  }
});

Shoplift.UsersView = Ember.View.extend(Shoplift.ScrollableMixin, {
  elementId: 'profiles',
  templateName: 'shoplift/templates/users',
  scrollWidth: '434px',
  didInsertElement: function() {
    this._super();
  },
  willDestroyElement: function() {
	  this._super();
	}
});


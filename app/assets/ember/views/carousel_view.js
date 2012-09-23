Shoplift.LoadMoreView = Ember.View.extend({
  templateName: 'load-more',
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
		var that = this, 
		namespaceKeydown = this.get("namespaceKeydown"),
		time = 800,
		options = { axis: 'x' },
		KEY_RIGHT = 39,
		KEY_LEFT = 37;
	
		$(document).on(namespaceKeydown, function(e) {
		  e.preventDefault();
		  
		  var scrollWidth = that.get("scrollWidth");
		  
		  if(e.which === KEY_RIGHT) { 
				$.scrollTo("+=" + scrollWidth, time, options);
		  } else if(e.which === KEY_LEFT) { 
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
  templateName: 'items',
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
  templateName: 'users',
  scrollWidth: '434px',
  didInsertElement: function() {
    this._super();
  },
  willDestroyElement: function() {
	  this._super();
	}
});


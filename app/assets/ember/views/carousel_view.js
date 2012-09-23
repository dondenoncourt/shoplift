Shoplift.LoadMoreView = Ember.View.extend({
  templateName: 'load-more',
  elementId: 'load-more',
  didInsertElement: function() {
	var view = this;
	this.$().bind('inview', function(event, isInView, visiblePartX, visiblePartY) {
	  if (isInView) {
	  	console.log(visiblePartX + " " + visiblePartY)
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
  	var that = this;
	$.scrollTo("+=" + that.get("scrollWidth"), 800, {axis: 'x'});
  },
  prev: function() {
  	var that = this;
  	$.scrollTo("-=" + that.get("scrollWidth"), 800, {axis: 'x'});
  },
  didInsertElement: function() {
  	var that = this;
	$(document).on("keydown", function(e) {
	  if(e.which==39) { //next
		e.preventDefault();
		$.scrollTo("+=" + that.get("scrollWidth"), 800, {axis: 'x'});
	  }
	  if(e.which==37) { //prev
		e.preventDefault();
		$.scrollTo("-=" + that.get("scrollWidth"), 800, {axis: 'x'});
	  }
  	});  
  },
  willRemoveElement: function() {
	  $(document).off("keydown");
  }

});

Shoplift.ItemsView = Ember.View.extend(Shoplift.ScrollableMixin, {
  elementId: 'carousel',
  templateName: 'items',
  scrollWidth: '434px'
});

Shoplift.UsersView = Ember.View.extend(Shoplift.ScrollableMixin, {
  elementId: 'profiles',
  templateName: 'users',
  scrollWidth: '434px'
});


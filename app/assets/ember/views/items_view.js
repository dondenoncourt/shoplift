Shoplift.ItemView = Ember.View.extend({
  templateName: 'item',
  classNames: ['product', 'item'],

  tagsHref: function() {
  	return '#tags' + this.get('content.id');
  }.property('content.id'),
  tagsId: function() {
		return 'tags' + this.get('content.id');
  }.property('content.id'),
  quoteHref: function() {
		return '#quote' + this.get('content.id');
  }.property('content.id'),
  quoteId: function() {
		return 'quote' + this.get('content.id');
  }.property('content.id'),
  historyHref: function() {
  	return '#history' + this.get('content.id');
  }.property('content.id'),
  historyId: function() {
  	return 'history' + this.get('content.id');
  }.property('content.id'),
  
  isInView: false,
  drawerIsOpen: false,
  drawerIsAnimating: false,
  
  didInsertElement: function(ev) {	 
  	var that = this,
		  	time = 800
		  	drawerIsAnimating = that.get("drawerIsAnimating"),
		  	drawerIsOpen = that.get("drawerIsOpen");
		  	
  	this.$().bind('inview', function(event, isInView, visiblePartX, visiblePartY) {
  		if(isInView) {
  			that.set("isInView", true);
  		}
  	});
  	 
  	  
	  // Right Drawer Toggle
	  
	  this.$().on("click", ".product-sub-container", function(e) {
	  	e.preventDefault();
	  	if(!drawerIsAnimating && !$(e.toElement).hasClass("relift-this")) {
	  		var drawer = that.$(this).parent().next('.product-drawer-container').children('.product-drawer');
	  		var container = that.$(this).parent().parent('.product');
	  		toggleDrawer(drawer, container);
	  	}
	  });
	  this.$().on("click", ".drawer-opener", function(e) {
	  	e.preventDefault();
	  	if(!drawerIsAnimating) {
	  		var drawer = that.$(this).parent();
	  		var container = that.$(this).parent().parent().parent('.product');
	  		toggleDrawer(drawer, container);
	  	}
	  });
	  
	  var toggleDrawer = function(drawer, container) {
	  	var opener = drawer.children(".drawer-opener"),
	  			angle,
	  			drawerIsAnimating = that.get("drawerIsAnimating"),
	  			drawerIsOpen = that.get("drawerIsOpen");
	  
	  	if(!drawerIsAnimating) {
				that.set("drawerIsAnimating", true);
	  	} else {
				return;
		  }
	  	
	  	if(drawerIsOpen) {
		  	drawer.
		  		delay(62).
		  			transition({left: '-170px'}, 300, 'out');
		  } else {
		  	drawer.
		  		transition({left: '0'}, 300, 'out');
		  }
		  
		  drawer.toggleClass("drawer-hidden");
		  
		  if(drawerIsOpen) {
		  	container.
		  		animate({width:"394px"}, 600, 'easeOutBack').
		  		animate({width:"374px"}, 200, 'linear');
		  } else {
		  	container.
		  		delay(100).
		  			animate({width:"547px"}, 500, 'easeOutBack').
		  			animate({width:"567px"}, 200, 'linear');
		  }
		  		
		  if(drawerIsOpen) {
			  angle = '0deg';
		  } else {
		  	angle = '+45deg';
		  }
		  
		  opener.transition({rotate: angle}, time, function() { 
		  	that.set("drawerIsOpen", !drawerIsOpen); 
		  	that.set("drawerIsAnimating", false);
		  });
	  };
  },
  /*willDestroyElement: function() {
	  this.$(".product-sub-container").off("click");
	  this.$(".drawer-opener").off("click");
  }*/
});

Shoplift.ItemReliftView = Ember.View.extend({
	templateName: 'relift'
});

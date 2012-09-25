Shoplift.InViewMixin = Ember.Mixin.create({
	isInView: false,
	inViewDidInsert: function() {
		var that = this;
		
		this.$().on('inview', function(event, isInView, visiblePartX, visiblePartY) {
			if(isInView && !that.get("isInView")) {
				that.set("isInView", true);
			}
		});
	},
	inViewWilDestroy: function() {
		this.$().off("inview");
	}
})


Shoplift.ItemView = Ember.View.extend(Shoplift.InViewMixin, {
  templateName: 'item',
  classNames: ['product', 'item'],
  isInView: false,
  drawerIsOpen: false,
  drawerIsAnimating: false,
  
  isInViewDidChange: function() {
	  var controller = this.get("controller"),
	  		isInView = this.get("isInView");
	  		
	  if(isInView) {
	  	controller.incrementProperty("isInViewCount");
	  }
  }.observes('isInView'),

  initDrawer: function() {
	  var that = this,
	  time = 800
	  drawerIsAnimating = that.get("drawerIsAnimating"),
	  drawerIsOpen = that.get("drawerIsOpen");
	  
	  this.$().on("click", ".product-container", function(e) {
	  	e.preventDefault();
	  	if(!drawerIsAnimating && !$(e.toElement).hasClass("relift-this")) {
	  		var drawer = that.$(this).next('.product-drawer-container').children('.product-drawer');
	  		var container = that.$(this).parent('.product');
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
	  				transition({left: '-185px'}, 300, 'out', function() {
							this.parent().css({'z-index': '-1'});
						});
	  	} else {
	  		drawer.parent().css({'z-index': '2'});
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
  
  cleanupDrawer: function() {
	  this.$().off("click");
  },
  
  didInsertElement: function(ev) {	
  	this.inViewDidInsert();
  	this.initDrawer();
  },
  
  willDestroyElement: function() {
  	this.inViewWillDestroy();
  	this.cleanupDrawer();
  }
});

Shoplift.ItemReliftView = Ember.View.extend({
	templateName: 'relift'
});

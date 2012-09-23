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
  
  
  didInsertElement: function(ev) {
  	
  	
  	
	  this.$('.product-container').css({'opacity': '0.0'});
	  this.$('.product-container').animate({'opacity': '1.0'}, 2000);
	  
	  
	  
	  // Right Drawer Toggle
	  var that = this, drawerIsAnimating = false;
	  this.$('.product-drawer').css({x: '-170px'});
	  this.$(".product-sub-container").on("click", function(e) {
	  	e.preventDefault();
	  	console.log(e);
	  	if(!drawerIsAnimating && !$(e.toElement).hasClass("relift-this")) {
	  		var drawer = that.$(this).parent().next('.product-drawer-container').children('.product-drawer');
	  		var container = that.$(this).parent().parent('.product');
	  		toggleDrawer(drawer, container);
	  	}
	  });
	  this.$(".drawer-opener").on("click", function(e) {
	  	e.preventDefault();
	  	if(!drawerIsAnimating) {
	  		var drawer = that.$(this).parent();
	  		var container = that.$(this).parent().parent().parent('.product');
	  		toggleDrawer(drawer, container);
	  	}
	  });
	  
	  var toggleDrawer = function(drawer, container) {
	  	if(!drawerIsAnimating) {
	  		drawerIsAnimating = true;
	  		if(drawer.css('x') == '-170px') {
	  			drawer.transition({x: '0'}, 300, 'out');
	  		} else {
	  			drawer.delay(62).transition({x: '-170px'}, 300, 'out');
	  		}
	  		drawer.toggleClass("drawer-hidden");
	  		if(container.css('width') == '567px') {
	  			container.animate({width:"394px"}, 600, 'easeOutBack').animate({width:"374px"}, 200, 'linear');
	  		} else {
	  			container.delay(100).animate({width:"547px"}, 500, 'easeOutBack').animate({width:"567px"}, 200, 'linear');
	  		}
	  		var opener = drawer.children(".drawer-opener");
	  		if(opener.css('rotate') == '+45deg') {
	  			opener.transition({rotate: '0deg'}, 800, function() { drawerIsAnimating = false; drawerIsOpen = true; });
	  		} else {
	  			opener.transition({rotate: '+45deg'}, 800, function() { drawerIsAnimating = false; drawerIsOpen = true; });
	  		}
	  	}
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

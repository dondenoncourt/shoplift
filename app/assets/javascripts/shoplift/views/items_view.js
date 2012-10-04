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
	inViewWillDestroy: function() {
		if(this.$()) {
			this.$().off("inview");
		}
	}
})

Shoplift.TagField = Ember.TextField.extend({
	keyUp: function(e) {
		if(e.which === 13) {
			this.addTag();
		}
	},
	addTag: function() {
		var tagVal = this.get("value"),
				//newTag = Shoplift.store.find(Shoplift.Hashtagbrand, {value: tagVal}),
				item = this.get("context"),
				postData = {
					"item_id": item.get('id'),
					"hashtag_value": tagVal
				};
		
		//setTimeout(function() {
		//debugger;
		//console.log(newTag);
		//if(!newTag.isLoaded) {
			newTag = Shoplift.store.createRecord(Shoplift.Hashtagbrand, {value: tagVal});
		//}
		item.get("hashtagbrands").pushObject(newTag);
		
		$.ajax({
			url: '/hashtags/create',
			type: 'POST',
			data: postData
		});
		
		this.set("value", "");
		//item.store.commit();
		//console.log(item.get("hashtagbrands"));
		//}, 2000);
	}
});

Shoplift.ItemView = Ember.View.extend(Shoplift.InViewMixin, {
  templateName: 'shoplift/templates/item',
  classNames: ['product', 'item'],
  isInView: false,
  drawerIsOpen: false,
  drawerIsAnimating: false,
  tabClass: 'tab-pane',
  tagsTab: true,
  quoteTab: false,
  historyTab: false,
  
  showTags: function() {
	  this.set('tagsTab', true);
	  this.set('quoteTab', false);
	  this.set('historyTab', false);
  },
  showQuote: function() {
  	this.set('tagsTab', false);
  	this.set('quoteTab', true);
  	this.set('historyTab', false);
  },
  showHistory: function() {
  	this.set('tagsTab', false);
  	this.set('quoteTab', false);
  	this.set('historyTab', true);
  },
  
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
	  	var clickedElement = $(e.toElement);
	  
	  	e.preventDefault();
	  	if(!drawerIsAnimating && clickedElement.attr('class') && !clickedElement.is(".relift-this, .user")) {
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
  	if(this.$()) this.$().off("click");
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
	templateName: 'shoplift/templates/relift'
});

Shoplift.CarouselContainerView = Ember.View.extend({
  elementId: 'carousel',
  templateName: 'items',
  next: function(event) {
	event.preventDefault();
	var that = this;
	var once = true;
	this.$(".item").animate({left: "-=434"}, 500, function() {
	  if(once) {
	    that.get('controller').next();
	    once = false;
	  }
	//  $("#carousel").css({left: "434px"});
	});
  },
  prev: function(event) {
	this.get('controller').prev();
	$("#carousel").css({left: "-434px"});
	$("#carousel").animate({left: "+=434"}, 500);
  },
  didInsertElement: function() {
	  
  }


});

Shoplift.UserCarouselContainerView = Shoplift.CarouselContainerView.extend({
	elementId: 'profiles',
	templateName: 'users',
	next: function(event) {
		event.preventDefault();
		var that = this;
		var once = true;
		this.$(".item").animate({left: "-=560"}, 500, function() {
		  if(once) {
			that.get('controller').next();
			once = false;
		  }
		});
	},
	prev: function(event) {
		this.get('controller').prev();
		$("#profiles").css({"margin-left": "-560px"});
		$("#profiles").animate({left: "+=560"}, 500);
	},
});

Shoplift.HashtagbrandCarouselContainerView = Shoplift.CarouselContainerView.extend({
	elementId: 'carousel',
	templateName: 'hashtagbrands'
});
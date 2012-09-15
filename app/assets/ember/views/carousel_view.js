Shoplift.CarouselContainerView = Ember.View.extend({
  elementId: 'carousel',
  templateName: 'items',
  next: function(event) {
	event.preventDefault();
	//TODO: jquery code to animate the slide goes here

	//this.$(".product").animate({left: "-=434"}, 500, function() {
	  this.get('controller').next();
	/*  $("#carousel").css({left: "434px"});
	});*/
  },
  prev: function(event) {
	//And here
	this.get('controller').prev();
	/*$("#carousel").css({left: "-434px"});
	$("#carousel").animate({left: "+=434"}, 500);*/
  }


});

Shoplift.UserCarouselContainerView = Shoplift.CarouselContainerView.extend({
	elementId: 'carousel',
	templateName: 'users'
});

Shoplift.HashtagbrandCarouselContainerView = Shoplift.CarouselContainerView.extend({
	elementId: 'carousel',
	templateName: 'hashtagbrands'
});
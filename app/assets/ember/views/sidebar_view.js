Shoplift.ProfileSidebarView = Ember.View.extend({
  templateName: 'profile_sidebar',
  didInsertElement: function() {
		this.$(".profile-overlay").show();
		this.$(".profile-overlay").css({opacity: "0.0"});
		this.$(".profile-overlay").animate({opacity: "1.0"}, 500)
  },
  willRemoveElement: function() {
	  this.$(".profile-overlay").animate({opacity: "0.0"}, 500)
  }
});

Shoplift.HashtagbrandSidebarView = Ember.View.extend({
	templateName: 'hashtagbrand_sidebar',
	didInsertElement: function() {
			this.$(".tag-overlay").show();
			this.$(".tag-overlay").css({opacity: "0.0"});
			this.$(".tag-overlay").animate({opacity: "1.0"}, 500)
		},
})
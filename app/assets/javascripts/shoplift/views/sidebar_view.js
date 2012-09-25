Shoplift.ProfileSidebarView = Ember.View.extend({
  templateName: 'shoplift/templates/profile_sidebar',
  didInsertElement: function() {
		this.$(".profile-overlay").show();
		this.$(".profile-overlay").css({left: "-308px"});
		this.$(".profile-overlay").animate({left: "0px"}, 500);
  },
  willDestroyElement: function() {
	  this.$(".profile-overlay").animate({opacity: "0.0"}, 500);
  }
});

Shoplift.HashtagbrandSidebarView = Ember.View.extend({
	templateName: 'shoplift/templates/hashtagbrand_sidebar',
	didInsertElement: function() {
			this.$(".tag-overlay").show();
			this.$(".tag-overlay").css({left: "-308px"});
			this.$(".tag-overlay").animate({left: "0px"}, 500);
		},
});

Shoplift.ExploreSidebarView = Ember.View.extend({
	templateName: 'shoplift/templates/explore_sidebar',
	didInsertElement: function() {
		this.$(".explore-overlay").show();
		this.$(".explore-overlay").css({left: "-308px"});
		this.$(".explore-overlay").animate({left: "0px"}, 500);
	}
})
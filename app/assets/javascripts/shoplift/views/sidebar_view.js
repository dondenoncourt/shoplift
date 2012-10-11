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
});

Shoplift.CountdownController = Ember.Controller.extend();
Shoplift.CountdownView = Ember.View.extend({
	template: Ember.Handlebars.compile('{{#if view.followMore}}<img {{bindAttr src="view.countdownImg"}} />{{else}}<a {{action goHome href=true}}><img {{bindAttr src="view.countdownImg"}} /></a>{{/if}}'),
	classNames: ['follow-countdown'],
	
	countdown: function() {
		var followees = this.get('controller.content.followees.content');
		console.log(followees);
		//debugger;
		if(typeof followees !== "undefined" && followees !== null)
			return Math.max((5 - followees.length), 0);
		return 5;
	}.property('controller.content.followees.content'),
	
	followMore: function() {
		if(this.get('countdown') === 0)
			return false;
		return true;
	}.property('countdown'),
	
	countdownImg: function() {
		return '/img/follow-' + this.get("countdown") + '-more.png';
	}.property('countdown'),
	
	countdownAlt: function() {
		return 'Follow ' + this.get("countdown") + ' more people and then start shoplifting'
	}.property('countdown')
	
});

Shoplift.OnboardingController = Ember.Controller.extend();
Shoplift.OnboardingView = Ember.View.extend({
	template: Ember.Handlebars.compile('<div class="profile-box-container follow-instructions"><img src="/img/follow-instructions.png" alt="START HERE. Get to know the other members.  Follow at least five of them and you can start shopping." /></div>'),
})
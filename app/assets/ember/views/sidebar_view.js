Shoplift.ProfileSidebarView = Ember.View.extend({
  templateName: 'profile_sidebar',
  classNames: ['profile-overlay'],
  didInsertElement: function() {
	this.$().show();
  }
});
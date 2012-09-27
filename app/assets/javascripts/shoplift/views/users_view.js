Shoplift.UserView = Ember.View.extend({
  templateName: 'shoplift/templates/user',
  classNames: ['user'],
  didInsertElement: function() {
	//debugger;
  }
});

Shoplift.ProfileView = Ember.View.extend({
	templateName: 'shoplift/templates/profile',
	classNames: ['profile-box', 'item']
});
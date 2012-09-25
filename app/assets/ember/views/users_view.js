Shoplift.UserView = Ember.View.extend({
  templateName: 'user',
  classNames: ['user'],
  didInsertElement: function() {
	//debugger;
  }
});

Shoplift.UsersView = Ember.View.extend({
	templateName: 'users'
});

Shoplift.ProfileView = Ember.View.extend({
	templateName: 'profile',
	classNames: ['profile-box', 'item']
	
});
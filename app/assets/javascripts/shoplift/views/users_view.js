Shoplift.UserView = Ember.View.extend({
  templateName: 'shoplift/templates/user',
  classNames: ['user'],
  didInsertElement: function() {
	//debugger;
  }
});

Shoplift.UsersView = Ember.View.extend({
	templateName: 'shoplift/templates/users'
});

Shoplift.ProfileView = Ember.View.extend({
	templateName: 'shoplift/templates/profile',
	classNames: ['profile-box', 'item']
	
});
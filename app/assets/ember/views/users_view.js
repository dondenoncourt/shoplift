Shoplift.UserView = Ember.View.extend({
  templateName: 'user',
  didInsertElement: function() {
	//debugger;
  }
});

Shoplift.UsersView = Ember.View.extend({
	templateName: 'users'
});

Shoplift.ProfileView = Ember.View.extend({
	templateName: 'profile',
	classNames: ['product', 'item']
	
});
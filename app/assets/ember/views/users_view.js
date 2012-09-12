Shoplift.UserView = Ember.View.extend({
  templateName: 'user',
  didInsertElement: function() {
	//debugger;
  },
  click: function(event) {
	var userId = this.get("_parentView")._lastNormalizedValue._id;
	//console.dir(userId);
	router.send("showProfile", Shoplift.store.find(Shoplift.User, userId));
  }
});

Shoplift.UsersView = Ember.View.extend({
	templateName: 'users'
});

Shoplift.ProfileView = Ember.View.extend({
	templateName: 'profile',
	classNames: ['product', 'item']
});
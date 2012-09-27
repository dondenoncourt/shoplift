Shoplift.UserView = Ember.View.extend({
  templateName: 'shoplift/templates/user',
  classNames: ['user'],
  didInsertElement: function() {
	//debugger;
  }
});

Shoplift.ProfileView = Ember.View.extend({
	templateName: 'shoplift/templates/profile',
	classNames: ['profile-box', 'item'],
	following: false,
	
	didInsertElement: function() {
		this.get('isFollowing');
	},
	
	isFollowing: function() {
		var userId = this.get('content.id'),
				following = false,
				that = this;
		
		$.ajax({
			url: "/users/following/" + userId,
			type: 'GET',
			success: function(response) {
				//following = response.data.is_following
				that.set('following', response.is_following);
			}
		});
		
		return this.get('following');
	}.property('following'),
	
	follow: function() {
		var userId = this.get('content.id'),
				that = this;
				
		console.log(userId);
		$.ajax({
			url: "/subscriptions.json",
			type: 'POST',
			data: {"user_id": userId},
			success: function() {
				that.set('following', true)
			}
		});
		
	}
});
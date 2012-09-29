Shoplift.UserController = Ember.ObjectController.extend({
	itemsClasses: 'profile-count of-items',
	followeesClasses: 'profile-count of-followees',
	followersClasses: 'profile-count of-followers',
	tagsBrandsClasses: 'tags-brands',
	marginLeft: '313px',
	following: false,
	
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
				following = this.get('following'),
				that = this;
		
		if(following) {
			that.set('following', false);
			router.get("navController.currentUser.followees").pushObject(that.get('content'));
			$.ajax({
				url: "/subscriptions/" + userId,
				type: 'DELETE',
				//data: {"user_id": userId},
				success: function() {
					that.set('following', false);
				},
				error: function() {
					that.set('following', true);
				}
			});
		} else {
			that.set('following', true);
			$.ajax({
				url: "/subscriptions.json",
				type: 'POST',
				data: {"user_id": userId},
				success: function() {
					that.set('following', true);
				},
				error: function() {
					that.set('following', false);
				}
			});
		}
		
	}
});

Shoplift.UserItemsController = Ember.ArrayController.extend(Shoplift.LoadMoreMixin, {});

Shoplift.UsersController = Ember.ArrayController.extend({
	whoami: function() {
		var user;
		$.ajax({
			url: '/users/whoami',
			dataType: 'jsonp',
			type: 'GET',
			context: this,
			success: function(response){
				user = response.data.user
			},
			error: function() {
				
			}
		});
		return user;
	}.property()
});

Shoplift.UserFolloweesController = Shoplift.UsersController.extend({
	
});

Shoplift.UserFollowersController = Ember.ArrayController.extend();

Shoplift.UserHashtagbrandsController = Ember.ArrayController.extend({
	
	isEven: function() {
		this.toggleProperty('even');
		console.log(this.get('even'));
		return this.get('even');
	}
});
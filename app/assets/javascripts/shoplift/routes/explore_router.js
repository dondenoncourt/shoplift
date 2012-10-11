Shoplift.ExploreRoute = Ember.Route.extend({
	route: '/follow',
	showRecommended: Ember.Route.transitionTo('recommended'),
	showPopular: Ember.Route.transitionTo('popular'),
	showNearby: Ember.Route.transitionTo('nearby'),
	showFriends: Ember.Route.transitionTo('friends'),
	showInterests: Ember.Route.transitionTo('interests'),
	connectOutlets: function(router) {
		var user = router.get("currentUserController.content");
		
		router.get("exploreSidebarController").connectControllers('currentUser');
		router.get("applicationController").connectOutlet('carousel', 'exploreSidebar', user);
		router.get("applicationController").connectOutlet({
		  name: 'nav',
		  outletName: 'header'
		});
		router.get("navController").connectOutlet('logo', 'logo');
	},
	index: Ember.Route.extend({
		route: '/',
		redirectsTo: 'recommended'
	}),
	recommended: Ember.Route.extend({
		route: '/recommended',
		connectOutlets: function(router) {
			var user = router.get("exploreSidebarController.content");
				
			router.get("exploreSidebarController").connectOutlet({
				viewClass: Shoplift.UsersView,
				controller: router.get("recommendedController"),
				context: Shoplift.store.findAll(Shoplift.User) //router.get("exploreSidebarController").get("content").get("recommended")
			});
			
			if(typeof user === "undefined" || user.get("followees.content").length < 5) {
				router.get("exploreSidebarController").connectOutlet({
					viewClass: Shoplift.CountdownView,
					outletName: 'countdown'
				});
				
				router.get("recommendedController").connectOutlet('onboarding');
			}
		}
		
	}),
	popular: Ember.Route.extend({
		route: '/popular',
		connectOutlets: function(router) {
			router.get("exploreSidebarController").connectOutlet('popular');
		}
	}),
	nearby: Ember.Route.extend({
		route: '/nearby',
		connectOutlets: function(router) {
			router.get("exploreSidebarController").connectOutlet('nearby');
		}
	}),
	friends: Ember.Route.extend({
		route: '/friends',
		connectOutlets: function(router) {
			router.get("exploreSidebarController").connectOutlet('friends');
		}
	}),
	interests: Ember.Route.extend({
		route: '/interests',
		connectOutlets: function(router) {
			router.get("exploreSidebarController").connectOutlet('interests');
		}
	})
});
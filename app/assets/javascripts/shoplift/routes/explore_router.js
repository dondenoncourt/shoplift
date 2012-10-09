Shoplift.ExploreRoute = Ember.Route.extend({
	route: '/follow',
	showRecommended: Ember.Route.transitionTo('recommended'),
	showPopular: Ember.Route.transitionTo('popular'),
	showNearby: Ember.Route.transitionTo('nearby'),
	showFriends: Ember.Route.transitionTo('friends'),
	showInterests: Ember.Route.transitionTo('interests'),
	connectOutlets: function(router) {
		var user = router.get("navController.currentUser");
		
		router.get("applicationController").connectOutlet('carousel', 'exploreSidebar');
		//router.get("exploreSidebarController").connectOutlet('countdown', 'countdown', user);
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
			router.get("exploreSidebarController").connectOutlet({
				viewClass: Shoplift.UsersView,
				controller: router.get("recommendedController"),
				context: Shoplift.store.findAll(Shoplift.User) //router.get("exploreSidebarController").get("content").get("recommended")
			});
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
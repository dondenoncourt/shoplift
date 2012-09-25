Shoplift.ExploreRoute = Ember.Route.extend({
	route: '/explore',
	showRecommended: Ember.Route.transitionTo('recommended'),
	showPopular: Ember.Route.transitionTo('popular'),
	showNearby: Ember.Route.transitionTo('nearby'),
	showFriends: Ember.Route.transitionTo('friends'),
	showInterests: Ember.Route.transitionTo('interests'),
	connectOutlets: function(router) {
		router.get("applicationController").connectOutlet('carousel', 'exploreSidebar');
		router.get("applicationController").connectOutlet({
		  name: 'nav',
		  outletName: 'header'
		});
		router.get("navController").connectOutlet('logo');
	},
	index: Ember.Route.extend({
		route: '/'
	}),
	recommended: Ember.Route.extend({
		route: '/recommended',
		connectOutlets: function(router) {
			router.get("exploreSidebarController").connectOutlet({
				viewClass: Shoplift.UserCarouselContainerView,
				controller: router.get("recommendedController"),
				context: router.get("exploreSidebarController").get("content").get("recommended")
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
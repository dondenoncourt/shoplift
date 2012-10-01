Shoplift.PagesManager = Ember.StateManager.extend({
	initialState: 'root',
	enableLogging: true,
	page: 'shoplift/templates/page',
	root: Ember.State.extend({
		goHome: Ember.State.transitionTo('home'),
		goAdd: Ember.Route.transitionTo('add'),
		goSignout: Ember.Route.transitionTo("signout"), // I know there is a better way to do this without the second route
		goHelp: Ember.State.transitionTo('help'),
		setup: function(manager) {
			manager.set('controller.target', manager)
			manager.get('appController').connectOutlet({
				viewClass: Shoplift.NavView,
				controller: manager.get('controller'),
				outletName: 'header'
			})
		},
		home: Ember.State.extend({
			enter: function(manager) {
				Shoplift.get('router').send('goHome');
			}
		}),
		add: Ember.State.extend({
			setup: function(manager) {
				manager.get('controller').connectOutlet({
					viewClass: Ember.View.extend({
						templateName: 'shoplift/templates/add',
						elementId: 'content-page'
					}),
					outletName: 'page'
				});
			}
		}),
		signout: Ember.Route.extend({
			enter: function() {
				window.location = "/logout";
			}
		}),
		help: Ember.State.extend({
			setup: function(manager) {
				manager.get('controller').connectOutlet({
					viewClass: Ember.View.extend({
						templateName: 'shoplift/templates/help',
						elementId: 'content-page'
					}),
					outletName: 'page'
				});
			}
		})
	})
});
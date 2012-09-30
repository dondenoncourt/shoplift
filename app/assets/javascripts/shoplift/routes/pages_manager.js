Shoplift.PagesManager = Ember.StateManager.extend({
	initialState: 'root',
	enableLogging: true,
	page: 'shoplift/templates/page',
	root: Ember.State.extend({
		goHelp: Ember.State.transitionTo('help'),
		setup: function(manager) {
			manager.set('controller.target', manager)
			manager.get('appController').connectOutlet({
				viewClass: Shoplift.NavView,
				controller: manager.get('controller'),
				outletName: 'header'
			})
		},
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
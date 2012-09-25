/*Shoplift.MenuManager = Ember.StateManager.extend({
	initialState: 'closed',
	openMenu: Ember.State.transitionTo('open'),
	closeMenu: Ember.State.transitionTo('closed'),
	closed: Ember.State.extend({
		enter: function() {
			//should only show the menu-off, maybe remove all other views?
		}
		
	}),
	open: Ember.State.extend({
		showSearch: Ember.State.transitionTo('search'),
		showInvite: Ember.State.transitionTo('invite'),
		showFeedback: Ember.State.transitionTo('feedback'),
		showEmbed: Ember.State.transitionTo('embed'),
		enter: function() {
			//should change the class to menu-on, and add the views for each menu item
		},
		exit: function() {
			//should remove all menu item views and change to menu-off
		},
		search: Ember.State.extend({
			enter: function() {
				//should remove the search item and replace it with the search box view
				view.pushObject('Shoplift.SearchBoxView');
			},
			exit: function() {
				//swap again
			}
			//in the router, we have an action executable from the root to send a search query to the search route
		}),
		invite: Ember.State.extend({
			enter: function() {
				
			}
		})
	})
})*/
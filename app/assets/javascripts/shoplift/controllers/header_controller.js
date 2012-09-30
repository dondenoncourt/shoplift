


/*Shoplift.NavManager = Ember.StateManager.create({
	initialState: 'closed',
	enableLogging: true,
	openMenu: function(manager, context) {
		//console.log(manager.get('controller'));
		manager.transitionTo('open');
	},
	closed: Ember.State.create({
		enter: function() {
			console.log(this.get('controller'));
		}
	}),
	open: Ember.State.create({
		enter: function(manager) {
			//manager.get('controller').get('');
		},
		searching: Ember.State.create({
			enter: function(manager) {
				
			}
		}),
		inviting: Ember.State.create({
			enter: function(manager) {
				
			}
		})
	})
});*/

Shoplift.NavController = Ember.ArrayController.extend({
	content: [
		{
			name: 'menu-buttons-add',
			type: 'top',
			action: 'goAdd'
		},
		{
			name: 'menu-buttons-follow',
			type: 'top',
			action: 'goExplore'
		},
		{
			name: 'menu-buttons-search',
			type: 'top',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-profile',
			type: 'top',
			action: 'goProfile controller.currentUser',
			subview: 'Shoplift.MenuFaceView'
		},
		{
			name: 'menu-buttons-invite',
			type: 'middle',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-embed',
			type: 'middle',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-feedback',
			type: 'middle',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-help',
			type: 'bottom',
			//target: 'pagesManager',
			action: 'goHelp'
		},
		{
			name: 'menu-buttons-about',
			type: 'bottom',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-terms',
			type: 'bottom',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-signout',
			type: 'bottom',
			action: 'goSignout'
		}
	],
	closed: true,
	currentUser: Shoplift.store.find(Shoplift.User, 1),
	whoami: function() {
		
		$.ajax({
			url: '/users/whoami',
			type: 'GET',
			context: this,
			success: function(response){
				this.set('currentUser', Shoplift.store.find(Shoplift.User, response.user));
			},
			error: function() {
				
			}
		});
	}.property('currentUser')
	/*target: Shoplift.NavManager,
	childViews: [Shoplift.MenuItemView.create({id: 'search'})],
	rootView: Ember.View.create({
		tagName: 'li',
		template: Ember.Handlebars.compile("<img {{action openMenu}} src='img/nav-menu.png' />"),
		didInsertElement: function() {
			var controller = this.get('controller')
			controller.set('target', Shoplift.NavManager);
			console.dir(this.get('controller.target'));
		}
	}),
	scaffoldingView: Ember.View.create({
		
	})*/
});
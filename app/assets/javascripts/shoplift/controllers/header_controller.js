


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

Shoplift.LogoController = Ember.Controller.extend();

Shoplift.CurrentUserController = Ember.ObjectController.extend({
	content: null,
	
	retrieveCurrentUser: function() {
		var controller = this;
		console.log('hello');
		Ember.$.getJSON('/users/whoami', function(data) {
			//Shoplift.store.load(Shoplift.User, data);
			var currentUser = Shoplift.store.find(Shoplift.User, data.user);
			controller.set('content', currentUser);
			console.log('back');
		});
	}
});

Shoplift.NavController = Ember.ArrayController.extend({
	menuIsClosed: true,
	menuIsOpening: false,
	menuIsClosing: false,
	currentUserBinding: Ember.Binding.oneWay('currentUserController.content'),
	
	content: [
		{
			name: 'menu-buttons-add',
			type: 'top',
			action: 'goAdd'
		},
		{
			name: 'menu-buttons-follow',
			type: 'top',
			router: true,
			action: 'goExplore'
		},
		{
			name: 'menu-buttons-search',
			type: 'top coming-soon',
			router: true,
			/*action: 'goSearch'*/
		},
		{
			name: 'menu-buttons-profile',
			type: 'top',
			router: true,
			action: 'goProfile controller.currentUser',
			subview: 'Shoplift.MenuFaceView'
		},
		{
			name: 'menu-buttons-invite',
			type: 'middle coming-soon',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-embed',
			type: 'middle coming-soon',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-feedback',
			type: 'middle coming-soon',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-help',
			type: 'bottom coming-soon',
			action: 'goHelp'
		},
		{
			name: 'menu-buttons-about',
			type: 'bottom coming-soon',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-terms',
			type: 'bottom coming-soon',
			action: 'goSearch'
		},
		{
			name: 'menu-buttons-signout',
			type: 'bottom',
			action: 'goSignout'
		}
	],
	
	goHome: function() {
		var router = Shoplift.get("router"),
				view = Shoplift.NavView;
		
		if(!this.get('menuIsClosed')) {
			this.set("menuIsClosing", true);
		}
		
		router.send("goHome");
	},
	toggleMenu: function() {
		if(!this.get('menuIsClosed')) {
			this.set("menuIsClosing", true);
		}
		else {
			this.set("menuIsOpening", true);
		}
	},
	menuWillOpen: function() {
		this.set('menuIsClosed', false);
	},
	menuDidOpen: function() {
		this.set("menuIsOpening", false);
	},
	menuDidClose: function() {
		this.set("menuIsClosing", false);
		this.set("menuIsClosed", true);
	}
});
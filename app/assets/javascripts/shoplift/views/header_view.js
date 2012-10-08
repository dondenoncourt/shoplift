Shoplift.LogoView = Ember.View.extend({
	templateName: 'shoplift/templates/logo',
});



/*Shoplift.NavView = Ember.View.extend({
	templateName: 'nav',
	classNames: ['header', 'navbar-fixed-top'],
	menuView: Ember.ContainerView.create({*/
	
Shoplift.MenuFaceView = Ember.View.extend({
	//TODO: what the heck is going on in this template?
	template: Handlebars.compile('<img {{bindAttr src="controller.currentUser.thumbUrl"}} />{{controller.currentUser}}')
});
	
Shoplift.MenuItemView = Ember.View.extend({
	classNameBindings: ['content.name', 'content.type'],
	templateName: 'shoplift/templates/menuitem', //Ember.Handlebars.compile("&nbsp;"),
	tagName: 'li',
	
	click: function(e) {
		var action = this.get("content.action").split(" "),
				target = this.get("controller.target"),
				router = this.get("content.router"),
				that = this;
		
		if(router) {
			this.get("controller").toggleMenu();
			target = Shoplift.get('router');
		}
		
		if(action.length == 2) {
			target.send(action[0], this.get(action[1]));
		} else {
			target.send(action[0]);
		}
	}
});

Shoplift.NavView = Ember.View.extend({
	templateName: 'shoplift/templates/menuitems',
	elementId: 'nav',
	classNames: ['header', 'navbar-fixed-top'],
	classNameBindings: ['closed'],
	closedBinding: 'controller.menuIsClosed',
	menuIsOpeningBinding: 'controller.menuIsOpening',
	menuIsClosingBinding: 'controller.menuIsClosing',
	height: 521,
	animationTime: 200,
	
	didInsertElement: function() {
		var menu = this.$("#menu ul"),
				height = this.get("height");
		
		this.get('controller.whoami');
		menu.transition({y: '-=' + height + 'px'}, 0);
		this.addObserver('controller.menuIsOpening', this, this.toggleMenu);
		this.addObserver('controller.menuIsClosing', this, this.toggleMenu);
	},
	
	openMenu: function() {
		var menu = this.$("#menu ul"),
				height = this.get("height"),
				time = this.get("animationTime"),
				controller = this.get("controller");
		
		controller.menuWillOpen();
		//menu.transition({y: '-=' + height + 'px'}, 0);
		menu.transition({y: '+=' + height + 'px'}, time, function() {
			controller.menuDidOpen()
		});
	},
	
	closeMenu: function() {
		var menu = this.$("#menu ul"),
				height = this.get("height"),
				time = this.get("animationTime"),
				controller = this.get("controller");
		
		menu.transition({y: '-=' + height + 'px'}, time, function() {
			controller.menuDidClose();
			//menu.transition({y: '+=' + height + 'px'}, 0);
		});
	},
	
	toggleMenu: function() {
		if(this.get('controller.menuIsOpening')) {
			this.openMenu();
			return;
		}
		if(this.get('controller.menuIsClosing')) {
			this.closeMenu();
			return;
		}
	}
	
});


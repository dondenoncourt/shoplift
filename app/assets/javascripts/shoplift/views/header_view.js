Shoplift.LogoView = Ember.View.extend({
	templateName: 'shoplift/templates/logo',
});



/*Shoplift.NavView = Ember.View.extend({
	templateName: 'nav',
	classNames: ['header', 'navbar-fixed-top'],
	menuView: Ember.ContainerView.create({*/
	
Shoplift.MenuFaceView = Ember.View.extend({
	template: Handlebars.compile('<img {{bindAttr src="controller.currentUser.avatar"}} />{{avatar}} - {{controller}} - {{controller.currentUser}}')
});
	
Shoplift.MenuItemView = Ember.View.extend({
	classNameBindings: ['content.name', 'content.type'],
	templateName: 'shoplift/templates/menuitem', //Ember.Handlebars.compile("&nbsp;"),
	tagName: 'li',
	
	click: function(e) {
		var action = this.get("content.action").split(" "),
				target = this.get("content.target"),
				that = this;
		
		if(target) {
			this.get("controller").toggleProperty('closed');
			Shoplift.get('router').get(target).send(action[0]);
		} else {
			if(action.length == 2) {
				Shoplift.get('router').send(action[0], this.get(action[1]));
			}
			else {
				//Shoplift.get('router').send(action[0]);
				this.get("controller.target").send(action[0]);
			}
		}
		/*Shoplift.get('router').send(this.get("content.action"), { 
			user_id: '3' 
		}); //this.get("content.params"));
		Shoplift.get('router').send('showProfile', { 
			user_id: '3' 
		});*/
	}
});

Shoplift.NavView = Ember.View.extend({
	templateName: 'shoplift/templates/menuitems',
	elementId: 'nav',
	classNames: ['header', 'navbar-fixed-top'],
	classNameBindings: ['closed'],
	closedBinding: 'controller.closed',
	didInsertElement: function() {
		this.get('controller.whoami');
	},
	toggleMenu: function() {
		var that = this;
		
		if(this.get('closed')) {
			this.set('closed', false);
			this.$("#menu ul").transition({y: '-=521px'}, 0);
			this.$("#menu ul").transition({y: "+=521px"}, 200);
		}
		else {
			this.$("#menu ul").transition({y: "-=521px"}, 200, function() {
				that.set('closed', true);	
				that.$("#menu ul").transition({y: '+=521px'}, 0);
			});
		}
	}
});


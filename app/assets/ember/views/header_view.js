Shoplift.LogoView = Ember.View.extend({
	templateName: 'logo',
});



/*Shoplift.NavView = Ember.View.extend({
	templateName: 'nav',
	classNames: ['header', 'navbar-fixed-top'],
	menuView: Ember.ContainerView.create({*/
	
Shoplift.MenuItemView = Ember.View.extend({
	classNameBindings: ['content.name', 'content.type'],
	template: Ember.Handlebars.compile("&nbsp;"),
	tagName: 'li',
	click: function(e) {
		this.get("controller").toggleProperty('closed');
		Shoplift.get('router').send(this.get("content.action"));
		/*Shoplift.get('router').send(this.get("content.action"), { 
			user_id: '3' 
		}); //this.get("content.params"));
		Shoplift.get('router').send('showProfile', { 
			user_id: '3' 
		});*/
	}
});

Shoplift.NavView = Ember.View.extend({
	templateName: 'menuitems',
	elementId: 'nav',
	classNames: ['header', 'navbar-fixed-top'],
	classNameBindings: ['closed'],
	closedBinding: 'controller.closed',
	toggleMenu: function() {
		this.toggleProperty('closed');
	}
});


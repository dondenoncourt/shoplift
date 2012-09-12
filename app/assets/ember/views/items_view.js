Shoplift.ItemsView = Ember.View.extend({
	templateName: 'items',
	drawerView: Ember.View.extend({
		// click: function(event) {
		// 	alert("helo!");
		// }
		// tagTabView = Ember.View.extend({
		// 	click: function(event) {
		// 		alert('humba humba!');
		// 	}
		// }),
		// tagsView = Ember.View.extend({
		// 	
		// })
	}),
	userViewClass: Ember.View.extend({
		click: function(event) {
			alert('user');
		}
	})
});

Shoplift.ItemView = Ember.View.extend({
  templateName: 'item',
  classNames: ['product', 'item']/*,
  click: function(event) {
	event.preventDefault();
	 //console.dir(this._parentView._parentView.get('controller'));
	//console.dir(this.get("content").get("id"));
	//console.dir(this.get("controller").get('content'));
	//this.get("controller").replaceContent(0, 1, Shoplift.store.find(Shoplift.Item, 3));
	 //this.get("controller").goTo(this.get("content").get("id"));
	this.$().animate({"width": "500px"});
  }*/
});

Shoplift.ItemReliftView = Ember.View.extend({
	templateName: 'relift'
});
// 
// Shoplift.DrawersView = Ember.View.extend({
// 	templateName: 'drawers',
// 	showTags: function(event) {
// 		alert('hello hello!');
// 	}
// });
// 
// Shoplift.TagDrawerView = Ember.View.extend({
// 	templateName: 'tag_drawer'
// });

// Shoplift.QuoteDrawerView = Ember.View.extend({
// 	templateName: 'quoteDrawer'
// });
// 
// Shoplift.HistoryDrawerView = Ember.View.extend({
// 	templateName: 'historyDrawer'
// });
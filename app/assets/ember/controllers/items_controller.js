Shoplift.ItemsController = Ember.ArrayController.extend({
	
});

Shoplift.ItemController = Ember.ObjectController.extend({

});

Shoplift.ItemReliftController = Ember.ObjectController.extend({
	submitForm: function(event) {
		//relift this item
		Shoplift.Item.createRecord(this.get("content"));
	}
});
// shoplift/app
//= require vendor
//= require_self
//= require ./shared/shared
//= require ./shoplift/shoplift
Shoplift = Ember.Application.create({
	rootElement: 'div#shoplift-container'
});



Ember.ENV.RAISE_ON_DEPRECATION = false;
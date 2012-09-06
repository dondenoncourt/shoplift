//= require ./store
//= require_tree ./models
//= require fixtureData
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes
//= require_self

var router = Shoplift.router = Shoplift.Router.create({
  location: 'hash'
});

Shoplift.initialize(router);


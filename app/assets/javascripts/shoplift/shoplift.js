
//= require_tree ./models
//= require ./fixtureData
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes
//= require_self

var router = Shoplift.router = Shoplift.Router.create({
  location: 'hash'
});



/*Ember.onLoad('Ember.Application', function(Application) {
    Ember.Application.registerInjection({
      name: 'navController',
    
      injection: function(app, router, property) {
        if (property === 'NavManager') {
          app[property].set('controller', router.get('navController'));
          //console.dir(router.get('navController.target'));
          //console.dir(router.get('navController'));
        }
      }
    });
});*/

Shoplift.initialize(router);


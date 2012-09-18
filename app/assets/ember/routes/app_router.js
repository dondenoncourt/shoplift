//= require_tree .
//= require_self

Shoplift.Router = Ember.Router.extend({
  enableLogging: true,
  root: Ember.Route.extend({
    route: '/',
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'app.index'
    }),
    app: Ember.Route.extend({
      route: '/app',
      showProfile: Ember.Route.transitionTo("user.index"),
      index: Ember.Route.extend({
        route: '/',
        redirectsTo: 'items'
      }),
      items: Shoplift.ItemsRoute,
      item: Shoplift.ItemRoute,
      users: Shoplift.UsersRoute,
      user: Shoplift.UserRoute,
      hashtagbrand: Shoplift.HashtagbrandRoute,
      explore: Shoplift.ExploreRoute
    })
  })
});







/*Shoplift.Router = Ember.Router.extend({
  enableLogging: true,
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'items'
    }),
    items: Ember.Route.extend({
      route: '/items',
      goHome: Ember.Route.transitionTo("index"),
      reliftItem: Ember.Route.transitionTo('relift'),
      connectOutlets: function(router, item) {
        console.dir(Shoplift.Item.find());
        router.get("applicationController").connectOutlet('items', Shoplift.Item.find());
      },
      index: Ember.Route.extend({
        route: '/'
        
      }),
      relift: Ember.Route.extend({
        route: '/:item_id/relift',
        connectOutlets: function(router, item) {
          router.get("itemReliftController").set("content", {});
          router.get("itemsController").connectOutlet("itemRelift");
        },
        exit: function(router) {
          router.get("itemsController").set("view", null);
        },
        submitForm: function(router, event) {
          //Call submitForm on the controller to save the new item
          router.get("itemReliftController").submitForm(event);
          router.get("store").commit();
          router.transitionTo("index");
        }
      })
    })
  })
});*/




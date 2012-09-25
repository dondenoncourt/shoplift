//= require_tree .
//= require_self

Shoplift.currentUser = 1;

Shoplift.Router = Ember.Router.extend({
  enableLogging: true,
  root: Ember.Route.extend({
    route: '/',
    goHome: Ember.Route.transitionTo("root.index"),
    goAdd: Ember.Route.transitionTo("index"),
    goExplore: Ember.Route.transitionTo("explore.index"),
    goSearch: Ember.Route.transitionTo("hashtagbrand.index"),
    goProfile: Ember.Route.transitionTo("user.index"),
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'app.index'
    }),
    alpha: Ember.Route.extend({
      route: '/alpha',
      connectOutlets: function(router, user) {
        if(!user) {
          user = Shoplift.User.find(3);
        }
        console.dir(user.get("items"));
        router.get("applicationController").connectOutlet({
          viewClass: Shoplift.ItemsView,
          controller: router.get("userItemsController"),
          outletName: 'carousel',
          context: user.get("items")
        }); 
        router.get("applicationController").connectOutlet({
          name: 'nav',
          outletName: 'header'
        });
        router.get("navController").connectOutlet('logo');
      },
      index: Ember.Route.extend({
        route: '/',
        
      })
    }),
    app: Ember.Route.extend({
      route: '/app',
      showProfile: Ember.Route.transitionTo("user.index"),
      showTag: Ember.Route.transitionTo('hashtagbrand.index'),
      index: Ember.Route.extend({
        route: '/',
        redirectsTo: 'items'
      }),
      items: Shoplift.ItemsRoute,
      item: Shoplift.ItemRoute,
      users: Shoplift.UsersRoute,
      user: Shoplift.UserRoute,
      hashtagbrand: Shoplift.HashtagbrandRoute,
      search: Shoplift.SearchRoute,
      explore: Shoplift.ExploreRoute
    })
  })//,
  //vanity: Shoplift.VanityRoute
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




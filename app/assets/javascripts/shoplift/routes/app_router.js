//= require_tree .
//= require_self

Shoplift.currentUser = 1;

Shoplift.Router = Ember.Router.extend({
  enableLogging: true,
  root: Ember.Route.extend({
    route: '/',
    goHome: Ember.Route.transitionTo("root.index"),
    goItems: Ember.Route.transitionTo("items.index"),
    goExplore: Ember.Route.transitionTo("explore.index"),
    goSearch: Ember.Route.transitionTo("hashtagbrand.index"),
    goProfile: Ember.Route.transitionTo("user.index"),
    
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'app.index'
    }),
    app: Ember.Route.extend({
      route: '/app',
      showProfile: Ember.Route.transitionTo("user.index"),
      showTag: Ember.Route.transitionTo('hashtagbrand.index'),
      
      connectOutlets: function(router) {
        var applicationController = router.get("applicationController"),
            navController = router.get("navController"),
            pagesManager = Shoplift.PagesManager.create({
              appController: applicationController,
              controller: navController
            });
        
        router.get("currentUserController").retrieveCurrentUser(); //could be refactored using init: instead
        navController.connectControllers("currentUser");
        
        
      },
      
      index: Ember.Route.extend({
        route: '/',
        connectOutlets: function(router) {
          setTimeout(function() {
            if(router.get("currentUserController.content.followees.length") < 5) {
              router.send("goExplore");
              console.log("not enough followers");
            }
            else {
              router.send("goItems");
            }
            console.log("enough" + router.get("navController.currentUser.followees.length"));
          }, 1000); //TODO: this wait probably shouldn't be hard coded in here
        }
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
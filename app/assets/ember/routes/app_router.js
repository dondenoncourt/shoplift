Shoplift.Router = Ember.Router.extend({
  enableLogging: true,
  root: Ember.Route.extend({
    route: '/',
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'app.items'
    }),
    app: Ember.Route.extend({
      showProfile: Ember.Route.transitionTo("users.show.items"),
      items: Ember.Route.extend({
        route: '/items',
        connectOutlets: function(router, items) {
          Shoplift.Item.find();
          router.get("applicationController").connectOutlet({
            name: 'carouselContainer',
            outletName: 'carousel',
            context: Shoplift.store.findMany(Shoplift.Item, [1,2,3,4])
          });
          router.get("applicationController").connectOutlet({
            name: 'logo',
            outletName: 'header'
          });
        },
        index: Ember.Route.extend({
          route: '/'
        }),
        show: Ember.Route.extend({
          route: '/:id',
          deserialize: function(router, params) {
            return Shoplift.Item.find(params.id);
          },
          connectOutlets: function(router, item) {
            router.get("applicationControler").connectOutlet("items", item);
          }
        }) // end items/show
      }), //end items
      /*users: Ember.Route.extend({
        route: '/users',
        connectOutlets: function(router, users) {
          router.get('applicationController').connectOutlet({
            name: 'users',
            outletName: 'sidebar',
            context: Shoplift.User.findAll()
          });
        },
        index: Ember.Route.extend({
          route: '/'
        }) 
      }),*/ //end users
      users: Ember.Route.extend({
        route: '/users',
        showItems: Ember.Route.transitionTo("show.items"),
        showFollowees: Ember.Route.transitionTo("show.followees"),
        showFollowers: Ember.Route.transitionTo("show.followers"),
        showHashtags: Ember.Route.transitionTo("show.hashtags"),
        index: Ember.Route.extend({
          route: '/'
        }),
        show: Ember.Route.extend({
          route: '/:user_id',
          connectOutlets: function(router, user) {
            router.get("applicationController").connectOutlet({
              viewClass: Shoplift.ProfileSidebarView,
              controller: router.get("userController"),
              outletName: 'sidebar',
              context: user //Shoplift.store.find(Shoplift.User, 2) //Shoplift.store.find(Shoplift.User, user._id)
            }); 
            router.get("applicationController").connectOutlet({
              viewClass: Shoplift.FaceView,
              outletName: 'header',
              controller: router.get("userController"),
              context: user
            })
          },
          index: Ember.Route.extend({
            route: '/',
            redirectsTo: 'items'
          }),
          items: Ember.Route.extend({
            route: '/items',
            connectOutlets: function(router, user) {
              /*Shoplift.store.load(Shoplift.Item, {
                id: 7,
                name: "Something 7",
                relifts: "5",
                brand: "Salvation Army",
                comment: "I love it",
                url: "http://google.com",
                price: "88",
                photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
                user_id: 2
              });*/
              router.get("applicationController").connectOutlet({
                name: 'carouselContainer',
                outletName: 'carousel',
                context: router.get("userController").get("content").get("items")
              });
            }
          }), //end users/show/items
          followees: Ember.Route.extend({
            route: '/followees',
            connectOutlets: function(router, user) {
              router.get("applicationController").connectOutlet({
                name: 'userCarouselContainer',
                outletName: 'carousel',
                context: router.get("userController").get("content").get("followers")
              });
            }
          }), //end users/show/followees
          followers: Ember.Route.extend({
            route: '/followers',
            connectOutlets: function(router, user) {
              router.get("applicationController").connectOutlet({
                name: 'userCarouselContainer',
                outletName: 'carousel',
                context: router.get("userController").get("content").get("followers")
              });
            }
          }), //end users/show/followers
          hashtags: Ember.Route.extend({
            route: '/hashtags',
            connectOutlets: function(router, tags) {
              router.get("applicationController").connectOutlet({
                name: 'hashtags',
                outletName: 'carousel',
                context: Shoplift.store.findMany(Shoplift.Tag, [1,2,3]) //router.get("userController").get("content").get("hashtags")
              })
            }
          }) // end users/show/hashtags
        }) //end users/show
      }) //end users
    })
  }) //end root
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




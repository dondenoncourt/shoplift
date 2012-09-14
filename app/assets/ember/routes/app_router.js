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
          /* router.get("applicationController").connectOutlet({
            
            outletName: 'sidebar'
          }); */
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
      users: Ember.Route.extend({
        route: '/users',
        /*showItems: Ember.Route.transitionTo("show.items"),
        showFollowees: Ember.Route.transitionTo("show.followees"),
        showFollowers: Ember.Route.transitionTo("show.followers"),
        showHashtags: Ember.Route.transitionTo("show.hashtags"),*/
        index: Ember.Route.extend({
          route: '/'
        }),
      }),
      user: Ember.Route.extend({
        route: '/users/:user_id',
        showItems: Ember.Route.transitionTo("items"),
        showFollowees: Ember.Route.transitionTo("followees"),
        showFollowers: Ember.Route.transitionTo("followers"),
        showHashtags: Ember.Route.transitionTo("hashtags"),
        connectOutlets: function(router, user) {
          router.get("applicationController").connectOutlet({
            viewClass: Shoplift.ProfileSidebarView,
            controller: router.get("userController"),
            outletName: 'carousel',
            context: user
          }); 
          //console.dir(user.get("items"));
          router.get("applicationController").connectOutlet({
            viewClass: Shoplift.FaceView,
            controller: router.get("userController"),
            outletName: 'header',
            context: user
          })
        },
        index: Ember.Route.extend({
          route: '/',
        }),
        items: Ember.Route.extend({
          route: '/items',
          connectOutlets: function(router, items) {
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
            console.dir(items);
            router.get("userController").connectOutlet({
              name: 'carouselContainer',
              context: items //router.get("userController").get("content").get("items")
            });
          }
        }), //end users/show/items
        followees: Ember.Route.extend({
          route: '/followees',
          connectOutlets: function(router) {
            router.get("userController").connectOutlet('userCarouselContainer');
          }
        }), //end users/show/followees
        followers: Ember.Route.extend({
          route: '/followers',
          connectOutlets: function(router, followers) {
            router.get("applicationController").connectOutlet({
              name: 'userCarouselContainer',
              outletName: 'carousel',
              context: followers //router.get("userController").get("content").get("followers")
            });
          }
        }), //end users/show/followers
        hashtagbrands: Ember.Route.extend({
          route: '/tags',
          connectOutlets: function(router, tags) {
            router.get("applicationController").connectOutlet({
              name: 'hashtags',
              outletName: 'carousel',
              context: router.get("userController").get("content").get("hashtags")
            })
          }
        }) // end user/hashtags
      }) //end user
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




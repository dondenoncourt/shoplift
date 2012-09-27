Landing.User = Ember.Object.extend({
  new: false,
  email: null,
  name: null,
  birthday: null,
  handle: null,
  url: "theshoplift.com/",
  shortUrl: function(key, value) {
  	var url = this.get('url'),
  			handle = this.get('handle');
  	
	  if(arguments.length === 1) {
	  
			return url + handle;
	  } else {
	  	if(value.indexOf("/") != -1) {
			  var x = value.split("/");
			  
			  this.set('handle', x[1]);
			  
			  return url + x[1];
			} else {
			
				return url;
			}
	  }
  }.property('url', 'handle'),
  
  shortUrlChanged: function() {
	  
  }.observes('shortUrl')
});
Landing.User.reopenClass({
  //user: null,
  findByEmail: function(email){
		$.ajax({
		  url: '/users',
		  dataType: 'jsonp',
		  data: {"email": email},
		  context: this,
		  success: function(response){
			response.data.forEach(function(user){
			  //this.users.addObject(Landing.User.create(user))
			  this.set("pic", user.avatar);
			  this.set("name", user.fullName);
			}, this)
		  },
		  error: function() {
			//this.users.addObject(Landing.User.create({"new": true, "email": email}));
			this.set("new", true);
		  }
		});
		return this;
  }
});


Landing.ApplicationController = Ember.Controller.extend({

});
Landing.EmailController = Ember.Controller.extend({
	emailClass: "",
	contentChanged: function() {
		console.log(this.get('content.email'));
		if(this.get('email') != "") {
			this.set("emailClass", "active");
		} else {
			this.set("emailClass", "");
		}
	}.observes('email')
});
Landing.LoadingController = Ember.ArrayController.extend({

});
Landing.ConfirmationController = Ember.ObjectController.extend({

});
Landing.SignupController = Ember.ObjectController.extend({
	
});
Landing.DemographicsController = Ember.ObjectController.extend({
	content: Landing.User.create(),
	genders: ["male", "female", "niether"],
	countries: ["United States", "Canada", "Mexico"],
	months: [
		{id: 1, month: "January"},
		{id: 2, month: "February"},
		{id: 3, month: "March"},
		{id: 4, month: "April"},
		{id: 5, month: "May"},
		{id: 6, month: "June"},
		{id: 7, month: "July"},
		{id: 8, month: "August"},
		{id: 9, month: "September"},
		{id: 10, month: "October"},
		{id: 11, month: "November"},
		{id: 12, month: "December"}
	],
	days: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
});

Landing.Router = Ember.Router.extend({
  enableLogging: true,
  root: Ember.Route.extend({
	route: '/',
	app: Ember.Route.extend({
	  route: '/',
	  learnMore: Ember.Route.transitionTo('letter'),
	  goHome: Ember.Route.transitionTo('index'),
	  next: Ember.Route.transitionTo('checking'),
	  connectOutlets: function(router) {
	  	console.log('hello');
		router.get("applicationController").connectOutlet('email', Landing.User.create({email: 'something'}));
	  },
	  index: Ember.Route.extend({
		route: '/'
	  }),
	  letter: Ember.Route.extend({
		route: '/letter',
		connectOutlets: function(router) {
		  router.get("emailController").connectOutlet('letter');
		},
		exit: function(router) {
			router.get("emailController").disconnectOutlet();
		}
	  }),
	  checking: Ember.Route.extend({
		connectOutlets: function(router, context) {
		  router.get("emailController").connectOutlet('loading', Landing.User.findByEmail(context));
		  router.get("loadingController").addObserver('content', function() {
			//var content = router.get("loadingController").get('content');
			//var user = content[0],
			var user = router.get("loadingController").get('content');
			if(user.new) {
			  return router.transitionTo('signup', user);
			} else {
			  return router.transitionTo('password', user);
			}
		  })
		}
	  }),
	  signup: Ember.Route.extend({
	    route: '/signup',
	    goDemographics: Ember.Route.transitionTo('demographics'),
	    connectOutlets: function(router, context) {
	  		router.get("applicationController").connectOutlet('signup', context);
	    }
	  }),
	  password: Ember.Route.extend({
	    route: '/password',
	    connectOutlets: function(router, context) {
	  		router.get("applicationController").connectOutlet('password');
	    }
	  }),
	  demographics: Ember.Route.extend({
		route: '/demographics',
		connectOutlets: function(router, context) {
			router.get("applicationController").connectOutlet('demographics', context);
		}  
	  }),
	  
	}),
	
  })
});

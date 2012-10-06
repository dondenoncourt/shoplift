Landing.Router = Ember.Router.extend
  location: 'hash'
  enableLogging: true
  root: Ember.Route.extend

    # index: Ember.Route.extend
    #   route: '/'
    #   redirectsTo: 'app.home'

    app: Ember.Route.extend
      route: '/'

      # Transitions
      learnMore: Ember.Route.transitionTo('letter')
      goHome: Ember.Route.transitionTo('index')

      # Child routes
      home: Ember.Route.extend
        route: '/'
        goSignin: Ember.Route.transitionTo('signin')
        goLearn: Ember.Route.transitionTo('learn')
        goSignup: Ember.Route.transitionTo('signup')
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet('home')
      
      learn: Ember.Route.extend
        route: '/learn'
        goSignup: Ember.Route.transitionTo('signup')
        prev: Ember.Route.transitionTo('home')
        connectOutlets: (router) ->
          router.get('applicationController').connectOutlet('letter')
          
      enterEmail: Ember.Route.extend
        route: '/email'
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet
            viewClass: Landing.EmailView
        
        user: null,
        
        userExists: ( ->
          user = this.get('user')
          if user?
            if user
              router.transitionTo 'returningUserPassword'
            else
              router.transitionTo 'checkYourEmail'
          user
        ).observes('user'),

        submit: (router) ->
          unless email = router.get('applicationController.email')
            router.get('applicationController.view.emailView').$().focus()
            return

          user = router.get('applicationController.content')
          
          
          router.transitionTo('signup', user)
          
          
          # this.set('user', user.get('exists'));
          
          
          
                    

          # Here, we try to create a user with the password provided.
          # If we get an error, that means the user already exists, so we
          # should take that user to sign in.
          #user.one 'didCreate', =>
            # Successfully created new user. Confirmation e-mail
            # has been sent. Redirect to the page that tells them
            # to check their email.
            #router.transitionTo 'returningUserPassword'
            #router.transitionTo 'checkYourEmail'

          #user.one 'becameInvalid', =>
            # There were errors creating the user, which means the
            # email was already taken, which means this user's
            # trying to log in.
            #router.transitionTo 'checkYourEmail'
            #router.transitionTo 'returningUserPassword'

          # Commit the transaction.
          #user.store.commit()

        # index: enter email.
        index: Ember.Route.extend
          route: '/'
          #connectOutlets: (router) ->
          prev: Em.K
          next: (router) -> router.send 'submit'

        # letter: site description for new users.
        letter: Ember.Route.extend
          connectOutlets: (router) ->
            router.get("applicationController").connectOutlet
              outletName: 'letterView'
              viewClass: Landing.LetterView
          exit: (router) ->
            router.get("applicationController").disconnectOutlet('letterView')
          prev: Ember.Route.transitionTo('index')
          next: Ember.Route.transitionTo('letter')

      # Where existing users enter their password.
      returningUserPassword: Ember.Route.extend
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet
            viewClass: Landing.ReturningUserPasswordView

        prev: Em.K
        next: (router) -> router.send 'submit'

        submit: (router) ->
          unless password = router.get('applicationController.password')
            router.get('applicationController.view.passwordView').$().focus()
            return

          alert "log in w password #{password}"
          #Landing.router.transitionTo 'returningUserPassword'

      checkYourEmail: Em.Route.extend
        route: '/check_email'
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet
            viewClass: Landing.CheckYourEmailView

      checking: Ember.Route.extend
        route: '/checking'
        connectOutlets: (router, context) ->
          router.get("emailController").connectOutlet('loading', Landing.User.findByEmail(context))
          router.get("loadingController").addObserver 'content', ->
            user = router.get("loadingController").get('content')
            if user.new
              return router.transitionTo('signup', user)
            else
              return router.transitionTo('password', user)

      signup: Ember.Route.extend
        route: '/signup'
        prev: (router) -> router.transitionTo('home')
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('signup', context)
          
        submit: (router) ->
          unless email = router.get('applicationController.email')
            router.get('applicationController.view.emailView').$().focus()
            return
          unless password = router.get('applicationController.password')
            router.get('applicationController.view.passwordView').$().focus()
            return
        
          user = router.get('applicationController.content')
          router.transitionTo('fullname', user)
      
      signin: Ember.Route.extend
        route: '/signin'
        prev: (router) -> router.transitionTo('home')
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('signin', context)
          
        # submit: (router) ->
        #   unless email = router.get('applicationController.email')
        #     router.get('applicationController.view.emailView').$().focus()
        #     return
        #   unless password = router.get('applicationController.password')
        #     router.get('applicationController.view.passwordView').$().focus()
        #     return
        # 
        #   user = router.get('applicationController.content')
        #   $.ajax
        #     url: '/users/sign_in'
        #     type: 'POST'
        #     data: 
        #       commit: 'Sign In'
        #       user:
        #         email: 'shoplift@dmzza.com'
        #         password: 't6ygfr5t'
          #TODO: Sumbit the form to rails for sign-in
      
      fullname: Ember.Route.extend
        route: '/fullname'
        prev: (router) -> router.transitionTo('signup')
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('name', context)
          
        submit: (router) ->
          unless name = router.get('applicationController.name')
            router.get('applicationController.view.nameView').$().focus()
            return
        
          user = router.get('applicationController.content')
          router.transitionTo('demographics', user)
      
      demographics: Ember.Route.extend
        route: '/demographics'
        prev: Em.K
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('demographics', context)
        
        submit: (router) ->
          unless router.get('applicationController.gender') isnt ""
            # router.get('applicationController.view.genderView').$().focus()
            return
          unless parseInt(router.get('applicationController.year')) < 2000
            console.log parseInt(router.get('applicationController.year'))
            # router.get('applicationController.view.yearView').$().focus()
            return
          unless zip = router.get('applicationController.zip')
            router.get('applicationController.view.zipView').$().focus()
            return
        
          user = router.get('applicationController.content')
          gender = (user.get("gender") is "male")
          if user.get("gender") is "neither"
            gender = ""
            
          $.ajax
            url: '/users'
            type: 'POST'
            data: 
              user:
                email: user.get("email")
                password: user.get("password")
                password_confirmation: user.get("password")
                full_name: user.get("name")
                country: user.get("country")
                zipcode: user.get("zip")
                "birthdate(2i)": user.get("month")
                "birthdate(3i)": user.get("day")
                "birthdate(1i)": user.get("year")
                sex: gender
                tos: 1
                
          router.transitionTo('photo', user)
      
      password: Ember.Route.extend
        route: '/password'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('password')
        
        submit: (router) ->
          unless password = router.get('applicationController.password')
            router.get('applicationController.view.passwordView').$().focus()
            return
          unless vanity = router.get('applicationController.vanity')
            router.get('applicationController.view.vanityView').$().focus()
            return
        
          user = router.get('applicationController.content')
          router.transitionTo('photo', user)
      
      photo: Ember.Route.extend
        route: '/photo'
        prev: Em.K
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('photo', context)
        
        submit: (router) ->
          user = router.get('applicationController.content')
          router.transitionTo('bio', user)
      
      bio: Ember.Route.extend
        route: '/bio'
        prev: Em.K
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('bio', context)
        
        submit: (router) ->
          if router.get("applicationController.view.red")
            return
          
          user = router.get('applicationController.content')
          $.ajax
            url: '/users'
            type: 'PUT'
            data: 
              user:
                biography: user.get("bio")
                url: user.get("url")
          
          router.transitionTo('confirm')
      
      confirm: Ember.Route.extend
        route: '/confirm'
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet('confirm')

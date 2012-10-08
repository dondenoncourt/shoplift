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
          unless password.length >= 6
            alert 'Password must be at least 6 characters long'
            router.get('applicationController.view.passwordView').$().val('')
            router.get('applicationController.view.passwordView').$().focus()
            return
        
          user = router.get('applicationController.content')
          user.set('passwordConfirmation', user.get('password'))
          router.set('passwordCopy', user.get('password'))
          router.transitionTo('fullname', user)
      
      signin: Ember.Route.extend
        route: '/signin'
        prev: (router) -> router.transitionTo('home')
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('signin', context)
          
        submit: (router) ->
          unless email = router.get('applicationController.email')
            router.get('applicationController.view.emailView').$().focus()
            return
          unless password = router.get('applicationController.password')
            router.get('applicationController.view.passwordView').$().focus()
            return
        
          user = router.get('applicationController.content')
          router.get('applicationController.view.passwordView').$().attr('disabled', 'disabled')
          $.ajax
            url: '/users/sign_in'
            type: 'POST'
            data: 
              user:
                email: email
                password: password
          .done( ->
            window.location = '/'
          )
          .fail( ->
            alert 'Wrong email or password'
            router.get('applicationController.view.passwordView').$().removeAttr('disabled')
            router.get('applicationController.view.passwordView').$().val('')
            router.get('applicationController.view.passwordView').$().focus()
          )
          #TODO: Sumbit the form to rails for sign-in
      
      fullname: Ember.Route.extend
        route: '/fullname'
        prev: (router) -> router.transitionTo('signup')
        next: (router) -> router.send 'submit'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('name', context)
          
        submit: (router) ->
          unless fullName = router.get('applicationController.fullName')
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
          # unless gender = router.get('applicationController.gender') and gender isnt ""
          #   #router.get('applicationController.view.genderView').$().focus()
          #   return
          # unless parseInt(router.get('applicationController.year')) < 2000
          #   console.log parseInt(router.get('applicationController.year'))
          #   #router.get('applicationController.view.yearView').$().focus()
          #   return
          # unless zip = router.get('applicationController.zipcode')
          #   router.get('applicationController.view.zipView').$().focus()
          #   return
        
          user = router.get('applicationController.content')
          # gender = (user.get("gender") is "male")
          # if user.get("gender") is "neither"
          #   gender = ""
          # switch gender
          #   when "male" then user.set("sex", true)
          #   when "female" then user.set("sex", false)
          #   when "" then user.set("sex", "")
          
          # $.ajax(
          #   url: '/users'
          #   type: 'POST'
          #   data: 
          #     user:
          #       email: user.get("email")
          #       password: user.get("password")
          #       password_confirmation: user.get("password")
          #       full_name: user.get("fullName")
          #       country: user.get("country")
          #       zipcode: user.get("zip")
          #       "birthdate(2i)": user.get("month")
          #       "birthdate(3i)": user.get("day")
          #       "birthdate(1i)": user.get("year")
          #       sex: user.get("sex")
          #       tos: 1
          # ).done( -> router.transitionTo('photo', user) )
          #  .fail( -> alert('Unexpected Error: Please try again') )
          
          user.store.commit()
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
        retry: (router) -> router.get("photoUploadController").retry()
        connectOutlets: (router, context) ->
          controller = router.get("applicationController")
          user  = controller.get('content')
          
          controller.connectOutlet('photo')
          controller.connectOutlet('photoUpload', 'photoUpload', user)
        
        submit: (router) ->
          controller = router.get('photoUploadController')
          router.get('applicationController.content').setProperties({
            originalUrl: controller.get('originalUrl')
            largeUrl: controller.get('largeUrl')
            thumbUrl: controller.get('thumbUrl')
          })
          
          user = router.get('applicationController.content')
          
          $.ajax
            url: '/users/sign_in'
            type: 'POST'
            data: 
              user:
                email: user.get('email')
                password: router.get('passwordCopy')
          .done( ->
            user.store.commit()
            router.transitionTo('bio', user)
          )
          .fail( ->
            console.log 'Wrong email or password'
          )
      
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
                biography: user.get("biography")
                url: user.get("url")
          
          router.transitionTo('confirm')
      
      confirm: Ember.Route.extend
        route: '/confirm'
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet('confirm')

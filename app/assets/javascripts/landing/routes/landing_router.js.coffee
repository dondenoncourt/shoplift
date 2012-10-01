Landing.Router = Ember.Router.extend
  location: 'hash'
  enableLogging: true
  root: Ember.Route.extend

    index: Ember.Route.extend
      route: '/'
      redirectsTo: 'app.enterEmail.index'

    app: Ember.Route.extend

      # Transitions
      learnMore: Ember.Route.transitionTo('letter')
      goHome: Ember.Route.transitionTo('index')

      # Child routes
      enterEmail: Ember.Route.extend
        connectOutlets: (router) ->
          router.get("applicationController").connectOutlet
            viewClass: Landing.EmailView

        submit: (router) ->
          unless email = router.get('applicationController.email')
            router.get('applicationController.view.emailView').$().focus()
            return

          user = router.get('applicationController.content')

          # Here, we try to create a user with the password provided.
          # If we get an error, that means the user already exists, so we
          # should take that user to sign in.
          user.one 'didCreate', =>
            # Successfully created new user. Confirmation e-mail
            # has been sent. Redirect to the page that tells them
            # to check their email.
            router.transitionTo 'checkYourEmail'

          user.one 'becameInvalid', =>
            # There were errors creating the user, which means the
            # email was already taken, which means this user's
            # trying to log in.
            router.transitionTo 'returningUserPassword'

          # Commit the transaction.
          user.store.commit()

        # index: enter email.
        index: Ember.Route.extend
          connectOutlets: (router) ->
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
        goDemographics: Ember.Route.transitionTo('demographics')
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('signup', context)
      password: Ember.Route.extend
        route: '/password'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('password')
      demographics: Ember.Route.extend
        route: '/demographics'
        connectOutlets: (router, context) ->
          router.get("applicationController").connectOutlet('demographics', context)

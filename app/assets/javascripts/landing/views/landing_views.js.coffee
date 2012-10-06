Landing.ApplicationView = Ember.View.extend
  templateName: 'landing/templates/application'

Landing.EmailView = Ember.View.extend
  templateName: 'landing/templates/email'
  elementId: 'email-container'


  didInsertElement: ->

    enquireParams =
      # REQUIRED
      # Triggered when the media query transitions
      # from *unmatched* to *matched*

      match: =>
        ###
        $.okvideo
          source: '47113550'
          volume: 1
          disablekeyControl: false
          loop: false
          hd: true
          adproof: false
        ###

        @$("#tagline").css( opacity: "0.0" )
        setTimeout =>
          return if @get('state') != 'inDOM'
          @$("#tagline").animate({opacity: "1.0"}, 7000)
        , 4000

        setTimeout =>
          return if @get('state') != 'inDOM'
          @$("#tagline").animate({opacity: "0.0"}, 7000)
        , 42000

        setTimeout =>
          return if @get('state') != 'inDOM'
          $("#okplayer").hide()
          $("img.background").css({opacity: "0.0", display: "block"})
          $("img.background").animate({opacity: "1.0"}, 500)
          @$("#tagline").animate({opacity: "1.0"}, 7000)
        , 50000

      # OPTIONAL
      # Triggered when the media query transitions
      # from a *matched* to *unmatched*
      unmatch: Em.K

    enquire.register("screen and (min-width: 771px)", enquireParams).listen()

    enquire.register("screen and (max-width: 770px)", =>

      # REQUIRED
      # Triggered when the media query transitions
      # from *unmatched* to *matched*
      match: =>
        return if @get('state') != 'inDOM'
        @$("img.background").show()
        @$("#seeMore").attr("href", "http://vimeo.com/47113550")
    ).listen()

Landing.TextField = Em.TextField.extend
  classNameBindings: ['active', 'content.isSaving']
  active: Em.computed.bool('value')
  keyUp: (event) ->
    if event.keyCode == 13
      Landing.router.send('submit')

Landing.EmailField = Landing.TextField.extend
  viewName: 'emailView'
  elementId: 'email-field'
  valueBinding: 'content.email'
  placeholder: 'Enter your email address'

Landing.PasswordField = Landing.TextField.extend
  viewName: 'passwordView'
  elementId: 'password-field'
  valueBinding: 'content.password'
  placeholderBinding: 'parentView.passwordPlaceholder'
  type: 'password'
  
Landing.NameField = Landing.TextField.extend
  viewName: 'nameView'
  elementId: 'name-field'
  valueBinding: 'content.name'

Landing.ZipField = Landing.TextField.extend
  viewName: 'zipView'
  elementId: 'zip-field'
  valueBinding: 'content.zip'

Landing.HomeView = Ember.View.extend
  templateName: 'landing/templates/home'
  elementId: 'home-container'

Landing.LetterView = Ember.View.extend
  templateName: 'landing/templates/letter'
  elementId: 'letter-container'
  # didInsertElement: ->
  #   @$().css({top: '1000px'})
  #   @$().transition({top: '0px'}, 800, 'out')

  close: ->
    # @$().transition({top: '1000px'}, 800, 'out')
    setTimeout =>
      Landing.router.send("prev")
    , 450

Landing.ReturningUserPasswordView  = Ember.View.extend
  templateName: 'landing/templates/returning_user_password'

Landing.CheckingView = Ember.View.extend
  templateName: 'landing/templates/checking'

Landing.SignupView = Ember.View.extend
  templateName: 'landing/templates/signup'
  elementId: 'signup-container'
  passwordPlaceholder: 'And choose a password'
  didInsertElement: ->
    this.get("emailView").$().focus()

Landing.SigninView = Ember.View.extend
  templateName: 'landing/templates/signin'
  elementId: 'signin-container'
  passwordPlaceholder: 'And your password'
  didInsertElement: ->
    this.get("emailView").$().focus()

Landing.PasswordView = Ember.View.extend
  templateName: 'landing/templates/password'
  
Landing.NameView = Ember.View.extend
  templateName: 'landing/templates/name'
  elementId: 'name-container'
  didInsertElement: ->
    this.get("nameView").$().focus()

Landing.DemographicsView = Ember.View.extend
  templateName: 'landing/templates/demographics'
  elementId: 'demographics-container'
  
Landing.PhotoView = Ember.View.extend
  templateName: 'landing/templates/photo'
  elementId: 'photo-container'

Landing.BioView = Ember.View.extend
  templateName: 'landing/templates/bio'
  elementId: 'bio-container'

Landing.CheckYourEmailView = Em.View.extend
  templateName: 'landing/templates/check_your_email'


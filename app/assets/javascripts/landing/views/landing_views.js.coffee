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
  valueBinding: 'content.fullName'

Landing.ZipField = Landing.TextField.extend
  viewName: 'zipView'
  elementId: 'zip-field'
  valueBinding: 'content.zipcode'

Landing.BioField = Em.TextArea.extend 
  viewName: 'bioView'
  elementId: 'bio-field'
  valueBinding: 'content.biography'
  placeholder: '110 characters max'

Landing.UrlField = Landing.TextField.extend
  viewName: 'urlView'
  elementId: 'url-field'
  valueBinding: 'content.url'
  placeholder: 'Enter your personal URL here.'

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
  passwordPlaceholder: 'Choose a password (6-20 chars)'
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
    this.get("controller").whoami()

Landing.DemographicsView = Ember.View.extend
  templateName: 'landing/templates/demographics'
  elementId: 'demographics-container'


Landing.PhotoUploadController = Ember.ObjectController.extend({
  isUploading: false
  hasUploaded: false
  # isDisabled: Em.computed.not('canUpload')
  fileIsDirty: false
  
  canUpload:   (->
    isDirty = @get('fileIsDirty')
    hasUploaded = @get('hasUploaded')
    isUploading = @get('isUploading')
    # is valid?
    
    isDirty and not hasUploaded and not isUploading
  ).property('fileIsDirty','hasUploaded','isUploading')
  
  retry: ->
    @set('hasUploaded', false)
    
  checkExisting: ->
    if @get('thumbUrl')?
      @set('hasUploaded', true)
  
  didSucceed: (results) ->
    originalUrl = results[':original'][0].url
    largeUrl = results.large[0].url
    thumbUrl = results.thumb[0].url
    
    @setProperties({
      originalUrl: originalUrl
      largeUrl: largeUrl
      thumbUrl: thumbUrl
      isUploading: false
      hasUploaded: true
    })
    return
   
  didStart:  -> @set('isUploading', true)
  didUpload: -> 
  didResult: ->
  didCancel: -> @set('isUploading', false)
  didError:  -> @set('isUploading', false)
  
  fileDidChange: -> @set('fileIsDirty', true)
})
  
Landing.PhotoUploadView = Ember.View.extend
  tagName: 'form'
  action:  'http://api2.transloadit.com/assemblies'
  enctype: 'multipart/form-data'
  method:  'POST'
  
  attributeBindings: 'tagName action enctype method'.w()
  
  template: Ember.Handlebars.compile('''
  {{#if hasUploaded}}
    <div class="face-circle"><img src="/img/face-circle.png"></div>
    <div class="circle-overflow"><img {{bindAttr src="thumbUrl"}} alt="your thumbnail"/> </div> 
    <a {{action retry}} class="photo-retry">Try again?</a>
  {{else}}
    <input type="hidden" name="params" value="{&quot;auth&quot;:{&quot;key&quot;:&quot;148166321cf34366a6696f36e79c4964&quot;},&quot;template_id&quot;:&quot;06560a762b784ecbbc7f3aca769b475d&quot;}" /> <!-- ,&quot;notify_url&quot;:&quot;http://beta.theshoplift.com/users&quot;}" /> -->
    <input class="photo-file-input" type="file" name="my_file" />
    <input class="photo-upload-submit" {{bindAttr disabled="isDisabled" }} type="submit" value="" />
  {{/if}}
  ''')
  
  init: -> window.a = @

  inputFileDidChange: (e) ->
    controller = @get('controller')
    
    controller.fileDidChange()
    @.$().submit()
    
  setupTransloadit: ->
    controller = @get('controller')
    @.$().transloadit
      wait: true
      autoSubmit: false
      processZeroFiles: false
      onSuccess:  => 
        results = @.$().data('transloadit.uploader').results
        controller.didSucceed(results)
        
      onStart:    => controller.didStart()
      onUpload:   => controller.didUpload()
      onResult:   => controller.didResult()
      onCancel:   => controller.didCancel()
      onError:    => controller.didError()
    controller.checkExisting()
    
    
  destroyTransloadit: ->
    
 
  didInsertElement: ->
    @setupTransloadit()
    @.$('input[type=file]').on('change', (e) => @inputFileDidChange(e) )
    
  willDestroyElement: ->
    @destroyTransloadit()

Landing.PhotoView = Ember.View.extend
  templateName: 'landing/templates/photo'
  elementId: 'photo-container'

Landing.BioView = Ember.View.extend
  templateName: 'landing/templates/bio'
  elementId: 'bio-container'
  red: false,
  charsRemaining: (() ->
    bio = @get('controller.content.biography')
    red = @get('red')
    length = 110
    console.log('controller.content.hit')
    unless bio?
      return length
    if bio.length > length && !red
      @set('red', true)
    else if bio.length <= length && red
      @set('red', false)
    return length - bio.length 
  ).property('controller.content.biography')

Landing.ConfirmView = Em.View.extend
  templateName: 'landing/templates/check_your_email'
  elementId: 'confirm-container'


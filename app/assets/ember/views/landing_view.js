Landing.ApplicationView = Ember.View.extend({
  templateName: 'landing-application',

});
Landing.EmailView = Ember.View.extend({
  templateName: 'landing-email',
  elementId: 'email-container',
  submit: function() {
	  console.log('submit'); 
  },
  didInsertElement: function() {
	var that = this;
	enquire.register("screen and (min-width: 771px)", {

	  // REQUIRED
	  // Triggered when the media query transitions
	  // from *unmatched* to *matched*

	  match: function() {
		/*$.okvideo({ source: '47113550', //'UoV3IXDqexw',  
			  volume: 1,
			  disablekeyControl: false, 
			  loop: false,
			  hd:true, 
			  adproof: false
			 });*/
			that.$("#tagline").css({opacity: "0.0"});
			setTimeout(function() {
			  that.$("#tagline").animate({opacity: "1.0"}, 7000);
			}, 4000); 
			setTimeout(function() {
			  that.$("#tagline").animate({opacity: "0.0"}, 7000);
			}, 42000); 
			setTimeout(function() {
			  $("#okplayer").hide();
			  $("img.background").css({opacity: "0.0", display: "block"});
			  $("img.background").animate({opacity: "1.0"}, 500);
			  that.$("#tagline").animate({opacity: "1.0"}, 7000);
			}, 50000); 
	  },

	  // OPTIONAL   
	  // Triggered when the media query transitions 
	  // from a *matched* to *unmatched*                        
	  unmatch : function() {}  

	}).listen();

	enquire.register("screen and (max-width: 770px)", {

		// REQUIRED
		// Triggered when the media query transitions
		// from *unmatched* to *matched*
		match : function() {
		  that.$("img.background").show();
		  that.$("#seeMore").attr("href", "http://vimeo.com/47113550");
	  }
	}).listen();
  }
});
Landing.LetterView = Ember.View.extend({
  templateName: 'landing-letter',
  elementId: 'letter-container',
  didInsertElement: function() {
	  this.$().css({top: '1000px'});
	  this.$().transition({top: '0px'}, 800, 'out');
  },
  close: function() {
	  this.$().transition({top: '1000px'}, 800, 'out');
	  setTimeout(function() {
		  Landing.router.send("goHome");
	  }, 850)
  }
});
Landing.CheckingView = Ember.View.extend({
  templateName: 'landing-checking'
});
Landing.SignupView = Ember.View.extend({
  templateName: 'landing-signup',
  elementId: 'signup-container'
});
Landing.PasswordView = Ember.View.extend({
  templateName: 'password'
});
Landing.DemographicsView = Ember.View.extend({
  templateName: 'landing-demographics',
  elementId: 'demographics-container'
})
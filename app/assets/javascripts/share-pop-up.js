// initialize overlay when page is scriptable
$(document).ready(function() {
	  // select the overlay element - and "make it an overlay"
	$(".shareBtn").overlay({
		top:0,
		// some mask tweaks suitable for facebox-looking dialogs
		mask: {
			color: '#19032f',
			loadSpeed: 200,
			opacity: .8,
		},
		// disable this for modal dialog-type of overlays
		closeOnClick: true,
		// load it immediately after the construction
		load: false,
	});
	
			
	$('.tsl-share-popup-email-icon').click(function () {
		$('.tsl-share-popup-scaffold').hide();
		$('.tsl-share-popup-twitter-icon, .tsl-share-popup-facebook-icon, .tsl-share-popup-pinterest-icon').removeClass('icon-active');
		$(this).addClass('icon-active');
		$('.tsl-share-popup-scaffold').fadeIn('slow');
	});
	
	$('.tsl-share-popup-pinterest-icon').click(function () {
		$('.tsl-share-popup-scaffold').hide();
		$('.tsl-share-popup-twitter-icon, .tsl-share-popup-facebook-icon, .tsl-share-popup-email-icon').removeClass('icon-active');
		$(this).addClass('icon-active');
		/*$('.tsl-share-popup-scaffold').fadeIn('slow');*/
	});
	
	$('.tsl-share-popup-facebook-icon').click(function () {
		$('.tsl-share-popup-scaffold').hide();
		$('.tsl-share-popup-twitter-icon, .tsl-share-popup-pinterest-icon, .tsl-share-popup-email-icon').removeClass('icon-active');
		$(this).addClass('icon-active');
		/*$('.tsl-share-popup-scaffold').fadeIn('slow');*/
	});
	
	$('.tsl-share-popup-twitter-icon').click(function () {
		$('.tsl-share-popup-scaffold').hide();
		$('.tsl-share-popup-facebook-icon, .tsl-share-popup-pinterest-icon, .tsl-share-popup-email-icon').removeClass('icon-active');
		$(this).addClass('icon-active');
		/*$('.tsl-share-popup-scaffold').fadeIn('slow');*/
	});
					
});

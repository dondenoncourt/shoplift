$(document).ready(function(){
  sitefuncs();
});

function sitefuncs() {
/*---------- Scroll Modify ----------*/

	var scrollTopStart = $(window).scrollTop();
	if(scrollTopStart>=145 && !$('.headWrap').hasClass('small')){
		$('.headWrap').addClass('small');
	} 

	$(window).scroll(function(){
		var scrolltop = $(window).scrollTop();
		if(scrolltop>=145 && !$('.headWrap').hasClass('small')){
			$('.headWrap').addClass('small');
		} else if(scrolltop<=145) {
			$('.headWrap').removeClass('small');
		}		
	});

/*---------- Search ----------*/

	$('input.text').focus(function(){
		if($(this).val()=="Search" || $(this).val()=="Add a Tag") {
			$(this).val('');	
		}
	});

/*---------- Product Actions ----------*/

	$('.product').hover(function(){
		$(this).find('.productDetails').stop().animate({ bottom:'0' },100)
	}, function() {
		$(this).find('.productDetails').stop().animate({ bottom:'-30px' },100)
	});

/*---------- Tag Scrollbar ----------*/
	
	$('div.scrollWrap').sbscroller();
	$('div.scrollWrap').hover(function(){
		$(this).find('.ui-slider-handle').fadeIn(100);
	}, function() {
		$(this).find('.ui-slider-handle').fadeOut(100);
	});

/*---------- Page Scroll ----------*/
	
	$('a.scrollTo').click(function(){
		var destination = $(this).attr('href');
		$.scrollTo(destination,300);
		return false;
	});

/*---------- Modal ----------*/
	
	$('.modal').click(function (e) {

    /* denoncourt mod: 
     * if rails attribute exists, don't append .html
     */
    var modaltype = $(this).attr('data-modal-rails');
    if (modaltype == null) {
      modaltype = $(this).attr('data-modaltype') + '.html';
    }
		if($(this).attr('data-modaltype')=="share") {
			var containerWidth = 428;
		} else {
			var containerWidth = 350;
		}

		$('#basic-modal-content').load('modal/' + modaltype, function() {

			var modalWidth = $('#basic-modal-content').height();

			$("#basic-modal-content").modal({
				opacity:80,
				overlayClose:true,
				onShow: function () {
					$('#simplemodal-container').css('height', 'auto');
				},
				focus:false,
				containerCss:{
					width:containerWidth
				}
			});
		});

		return false;
	});

}




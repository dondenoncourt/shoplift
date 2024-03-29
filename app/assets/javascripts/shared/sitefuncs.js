
$(document).ready(function(){
  sitefuncs();

  // show modal based on the link's url
  $('.modal_link').live('click', function() {
    showModal(this.href);
    return false;
  });

  // show modal based on form submission
  $('.modal_form').live('submit', function() {
    showModal(this.action, this.method, $(this).serialize());
    return false;
  });    
});

function sitefuncs() {
/*---------- Scroll Modify ----------*/

  if($('body').hasClass('landing')) {
    var scrollNum = 195;
  } else {
    var scrollNum = 145;
  }


  var scrollTopStart = $(window).scrollTop();
  if(scrollTopStart>=scrollNum && !$('.headWrap').hasClass('small')){
    $('.headWrap').addClass('small');
  }

  $(window).scroll(function(){
    var scrolltop = $(window).scrollTop();
    if(scrolltop>=scrollNum && !$('.headWrap').hasClass('small')){
      $('.headWrap').addClass('small');
    } else if(scrolltop<=scrollNum) {
      $('.headWrap').removeClass('small');
    }
  });

/*---------- Sign In ----------*/

  $('a.showSignup').click(function(){
    if($('div.signinOptions').is(':hidden')) {
      $('div.signinOptions').slideDown();
    }
    return false;
  });

/*---------- Help Page ----------*/

  $('.questionList h4 a').click(function(){
    if($(this).closest('li').hasClass('currentQ')) {
      $(this).closest('li').removeClass('currentQ');
    } else {
      $(this).closest('li').addClass('currentQ');
    }
    return false;
  });

/*---------- Search ----------*/

  $(document).on('focus', 'input.text', function(){
    if($(this).val()=="Search" || $(this).val()=="Add a Tag") {
      $(this).val('');
    }
  });

/*---------- Product Actions ----------*/

  $(document).on('mouseenter','.product', function (e) {
    $(this).find('.productDetails').stop().animate({ bottom:'0' },100)
  }).on('mouseleave','.product', function() {
    $(this).find('.productDetails').stop().animate({ bottom:'-30px' },100)
  });  

/*---------- Tabs ----------*/

  $('ul.tabs a').click(function(){
    $(this).closest('ul.tabs').children('li.current').removeClass('current');
    $(this).parent('li').addClass('current');
    var showDiv = $(this).attr('href');

    $(this).parents('div.productMeta').children('div.toggleWrap').hide();
    $(this).parents('div.productMeta').children(showDiv).show();
    $('div.scrollWrap').sbscroller('refresh');

    return false;
  });

/*---------- Tag Scrollbar ----------*/

  $('div.scrollWrap').sbscroller();
  $('div.scrollWrap').hover(function(){
    $(this).find('.ui-slider-handle').fadeIn(100);
  }, function() {
    $(this).find('.ui-slider-handle').fadeOut(100);
  });

/*---------- Page Scroll ----------*/

  $(window).scroll(function () {
    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 35) {
      $('.scrollTo').show();
    } else {
      $('.scrollTo').hide();
    }
  });

  $('a.scrollTo, ol.topicList a').click(function(){
    $.scrollTo(window);
    return false;
  });

/*---------- Modal ----------*/

  $(document).on('click', '.modal', function(){
    // denoncourt mod: * if rails attribute exists, don't append .html
    var modaltype = $(this).attr('data-modal-rails');
    if (modaltype == null) {
      modaltype = $(this).attr('data-modaltype') + '.html';
    }
    var selector = $(this).attr('data-modal-selector');
    showModal('/modal/' + modaltype, selector);
    return false;
  });

}

function showModal(href, selector) {
  $.ajax({
    url: href,
    type: 'get',
    complete: function(xhr, textStatus) {
    },
    success: function(data, textStatus, xhr) {
      $('body').append(data);
      $(selector).overlay({
        top:0,
        oneInstance: false,
        mask: {
          color: '#19032f',
          loadSpeed: 200,
          opacity: .8,
        },
        closeOnClick: true,
        load: true,
        onClose: function(x, y){
          $(selector).remove();
        }
      });
    },
    error: function(xhr, textStatus, errorThrown) {
      if (window.console) console.log(xhr);
      $('#basic-modal-content').html('Sorry, there was a problem with your request.');
    }
  });
}



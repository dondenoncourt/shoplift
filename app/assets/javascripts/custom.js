// JavaScript Document

// Drop Down
$(document).ready(function(){
  /*$('blockquote p').wrapInner('<span>'); now in html of _item.htm.erb --- whoever: delete next time you see this */
  $('.productBox:nth-child(3n)').addClass('active');

  $('.profilePan').hover(
  function () {
    $(this).addClass('active');
    //$(this).next('ul').fadeIn('fast');
    $('#mainMenu').fadeIn('fast');
    $('.productBox1').addClass('not-active-box');
  }
  );
  $('body, html').click(
  function () {
    $(this).removeClass('active');
    //$('.profilePan img').next('ul').fadeOut();
    $('#mainMenu').fadeOut();
    $('.arrowLink').removeClass('active');
    $('.arrowLink').children('ul').fadeOut();
    $('.productBox1').removeClass('not-active-box');
  }
  );

  $('.arrowLink').hover(
    function () {
      $(this).addClass('active');
      $(this).children('ul').fadeIn('fast');
    }
  );
  /*
  $('.arrowLink').hover(
    function () {
      $(this).addClass('active');
      $(this).children('ul').fadeIn('fast');
    },
    function () {
      $(this).removeClass('active');
      $(this).children('ul').fadeOut();
    }
  );
  $('.arrowLink a').click(function () {
      $('.arrowLink').addClass('active');
      $('.arrowLink').children('ul').fadeIn('fast');
  });
*/

});

// Slider
function highlight( items ) {
  items.filter(":eq(2)").addClass("active");
} 
function unhighlight( items ) {
  //items.addClass("inactive"),
  items.removeClass("active");
}

var clickevent = true; // for drawer slider
var lastPage = 0;
var currentPage = 1;
$(function() {
  lastPage = $('#lastPage').html();
  $('#carousel').carouFredSel({
    width: '100%',
    items: 5,
    auto : false,
    scroll: {
      items: 1,
      duration: 500,
      pauseDuration: 5000,
      //pauseOnHover    : true
    },
    prev: {
      onBefore: function(oldItems, newItems) {
        clickevent = true;
        unhighlight( oldItems );
      },
      onAfter : function(oldItems, newItems) {
        highlight( newItems );
      }
    },
    next: {
      onBefore: function(oldItems, newItems) {
        clickevent = true;
        expandItems();
        unhighlight( oldItems );
      },
      onAfter : function(oldItems, newItems) {
        highlight( newItems );
      }
    }
  });
  $("#next").click(function() {
    $("#carousel").trigger("next", 1);
    $('.productBox2').animate({ width: 'hide' });
    $('.productBox').animate({width:"374px"});
    $('.slideBtn').removeClass('slideOff');
  });
  $("#prev").click(function() {
    $("#carousel").trigger("prev", 1);
    $('.productBox2').animate({ width: 'hide' });
    $('.productBox').animate({width:"374px"});
    $('.slideBtn').removeClass('slideOff');
  });

  // Right Slide Toggle
  var clickevent = true;
  $(document).on('click', '.slideBtn', function() {
    if(clickevent == true) {
      $(this).addClass('slideOff');
      $(this).next('.productBox2').fadeIn('fast');
      $(this).next('.productBox2').animate({"z-index": "0"},1000);
      $('.productBox2-shadow').delay(800).fadeIn();
      $(this).parent('.productBox').animate({width:"551px"},1000);				
      clickevent = false;
      return false;
    } else {
      $(this).next('.productBox2').animate({"z-index": "-15"},1);
      $('.productBox2-shadow').fadeOut('fast');
      $(this).removeClass('slideOff');		
      $(this).next('.productBox2').animate({"right": "5"},1000);
      $(this).parent('.productBox').animate({width:"374px"},1000);
      $(this).next('.productBox2').fadeOut(200);
      clickevent = true;
      return false;
    }
  });

  //Tab Show Hide
  $('.tabContent1').show();
  $('.tabNav li:first-child').addClass('activeTab');
  $('.tabNav li').click(function(){
    var divId = "." + $(this).attr('rel');
      $(this).parent().siblings('div.tabContent').hide();
      $(this).parent().siblings(divId).fadeIn('fast');
      $(this).siblings().removeClass('activeTab');
      $(this).addClass('activeTab');
      return false;
  });
});
function expandItems() {
  currentPage++;
  if (currentPage <= lastPage) {
    $.ajax({
      url:'/timelines?page='+currentPage,
      type:'GET',
      success:function(data) {
        $('#carousel').append(data);
      },
      error:function(xhr,textStatus,errorThrown){
        alert(xhr.responseText);
      }
    });
  }
}

$(document).ready(function(){
  $(".videoContainer").height($(document).height());
});

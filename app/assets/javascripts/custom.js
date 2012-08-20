// JavaScript Document

// Drop Down
$(document).ready(function(){
  /*$('blockquote p').wrapInner('<span>'); now in html of _item.htm.erb --- whoever: delete next time you see this */
  $('.productBox:nth-child(3n)').addClass('active');

$('.profilePan img').hover(
function () {
  $(this).addClass('active');
  //$(this).next('ul').fadeIn('fast');
  $('#mainMenu').fadeIn('fast');
}
);
$('body, html').click(
function () {
  $(this).removeClass('active');
  //$('.profilePan img').next('ul').fadeOut();
  $('#mainMenu').fadeOut();
}
);

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
});

// Slider
function highlight( items ) {
  items.filter(":eq(1)").addClass("active");
} 
function unhighlight( items ) {
  //items.addClass("inactive"),
  items.removeClass("active");
}

var lastPage = 0;
var currentPage = 1;
$(function() { 
  lastPage = $('#lastPage').html();
  $('#carousel').carouFredSel({
    width: '100%',
    items: 3,
    auto : false,
    scroll: {
      items: 1,
      duration: 500,
      pauseDuration: 5000,
      //pauseOnHover    : true
    },
    prev: {
      onBefore: function(oldItems, newItems) {
        unhighlight( oldItems );
      },
      onAfter : function(oldItems, newItems) {
        highlight( newItems );
      }
    },
    next: {
      onBefore: function(oldItems, newItems) {
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
    $('.productBox').animate({width:"545px"});
    $('.slideBtn').removeClass('slideOff');
  });
  $("#prev").click(function() {
    $("#carousel").trigger("prev", 1);
    $('.productBox2').animate({ width: 'hide' });
    $('.productBox').animate({width:"545px"});
    $('.slideBtn').removeClass('slideOff');
  });
  
  
//  $(".slide").click(function() {
//     $(this).addClass('slideOff');
//     $(this).removeClass('slide');
//     $(this).next('.productBox2').animate({ width: 'show' });
//  }
//  );
//  $(".slideOff").click(function() {
//     $(this).removeClass('slideOff');
//     $(this).addClass('slide');
//     $(this).next('.productBox2').animate({ width: 'hide' });
//  }
//  );

// Right Slide Toggle
var clickevent = true;
$(".slideBtn").click(slideBtnHandler());
/*
 now in _item.html.erb
$(".slideBtn").click(function() {
  if(clickevent == true) {
    $(this).addClass('slideOff');
    $(this).next('.productBox2').fadeIn('fast');
    $(this).next('.productBox2').animate({"right": "14" , "z-index": "0"},1000);
    $(this).parent('.productBox').animate({width:"750px"},1000 , function() {});
    clickevent = false;
    return false;
  } else {
    $(this).next('.productBox2').animate({"z-index": "-5"},1);
    $(this).removeClass('slideOff');    
    $(this).next('.productBox2').animate({"right": "0"},1000);
    $(this).parent('.productBox').animate({width:"545px"},1000);
    $(this).next('.productBox2').fadeOut(200);
    clickevent = true;
    return false;
  }
});
*/
function slideBtnHandler() {
  if(clickevent == true) {
    $(this).addClass('slideOff');
    $(this).next('.productBox2').fadeIn('fast');
    $(this).next('.productBox2').animate({"right": "14" , "z-index": "0"},1000);
    $(this).parent('.productBox').animate({width:"750px"},1000 , function() {});
    clickevent = false;
    return false;
  } else {
    $(this).next('.productBox2').animate({"z-index": "-5"},1);
    $(this).removeClass('slideOff');    
    $(this).next('.productBox2').animate({"right": "0"},1000);
    $(this).parent('.productBox').animate({width:"545px"},1000);
    $(this).next('.productBox2').fadeOut(200);
    clickevent = true;
    return false;
  }
}


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
        if (window.console) console.log(data);
        $('#carousel').append(data);
      },
      error:function(xhr,textStatus,errorThrown){
        alert(xhr.responseText);
      }
    });
  }
}

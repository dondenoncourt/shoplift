// JavaScript Document

// Drop Down
$(document).ready(function(){
	$('blockquote p').wrapInner('<span>');
	$('.productBox:nth-child(3n)').addClass('active');

$('.profilePan #userImage').hover(
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
	$('#results.carousel').carouFredSel({					
		width: '100%',
    infinite: true,
		items: 3,
		scroll: {
			items: 1,
			duration: 9000,
			pauseDuration: 9000,
			pauseOnHover    : true
		},
    auto	: {
      onBefore: function(oldItems, newItems) {
        expandItems();
        unhighlight( oldItems );
      },
      onAfter	: function(oldItems, newItems) {
        highlight( newItems );
      }
    },
		prev: {
			onBefore: function(oldItems, newItems) {
				unhighlight( oldItems );
			},
			onAfter	: function(oldItems, newItems) {
				highlight( newItems );
			}
		},
		next: {
			onBefore: function(oldItems, newItems) {
        expandItems();
				unhighlight( oldItems );
			},
			onAfter	: function(oldItems, newItems) {
				highlight( newItems );
			}
		}
	});
	$("#next").click(function() {
		$("#results.carousel").trigger("next", 1);
	});
	$("#prev").click(function() {
		$("#results.carousel").trigger("prev", 1);
	});
});
function expandItems() {
  currentPage++;
  if (currentPage <= lastPage) {
    $.ajax({
      url:'/timelines2?page='+currentPage,
      type:'GET',
      success:function(data) {
        $('#results').append(data);
      },
      error:function(xhr,textStatus,errorThrown){
        alert(xhr.responseText);
      }
    });
  }
}

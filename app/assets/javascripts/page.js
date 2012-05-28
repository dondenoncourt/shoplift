// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//

/*
  Today at 3:51pm," "Yesterday at 3:51pm," "Sunday at 3:51pm," "Saturday..." etc. all the way back through the sixth day. 
  If seven or more days then "September 30, 2011" for all dates more than a week old.
*/
function formatDate(date) {
  var created_at = new Date(date);
  var formattedDate = '';
  var today = new Date();
  var lastWeek = new Date();
  lastWeek.setDate(new Date().getDate()-7);
  var yesterday = new Date();
  yesterday.setDate(new Date().getDate()-1);
  if (created_at > lastWeek) {
    if (created_at.getDay() == today.getDay()) {
      formattedDate = "Today at ";
    } else if (created_at.getDay() == yesterday.getDay()) {
      formattedDate = "Yesterday at ";
    } else {
      formattedDate = $.datepicker.formatDate("DD at ", created_at);
    }
    var hour = created_at.getUTCHours();
    var am_pm = 'am';
    if (hour > 12) {
      hour -= 12;
      am_pm = 'pm';
    }
    formattedDate += hour + ':' + created_at.getMinutes() + am_pm;
  } else {
    formattedDate = $.datepicker.formatDate("MM d, yy", created_at);
  }
  return formattedDate;
}
function handleAddTag() {
  $('form[name=add_tag_form]').last().submit(function () {
    var this_form = $(this);
    $.ajax({
      url:'/hashtags/create',
      type:'POST',
      dataType:'json',
      data: $(this).serialize(),
      success:function(data) {
        var lastLi = this_form.parent().parent().find('.tagList li').last();
        var clone = lastLi.clone();
        var lastLink = clone.find('a').last();
        if (lastLink.html() != null) {
          console.log(lastLink.html());
          clone.appendTo(this_form.parent().parent().find('.tagList'));
          //$(lastLink).find('img').html(data.value);
          lastLi.html('<a href="#"><img src="../img/global/user-thumb-holder.gif" alt="user-thumb-holder" width="25" height="25" class="user-tiny-thumb"/>'+data.value+'</a>');
        } else {
          lastLi.html('<a href="#"><img src="../img/global/user-thumb-holder.gif" alt="user-thumb-holder" width="25" height="25" class="user-tiny-thumb"/>'+data.value+'</a>');
        }
        $(this_form).find('input[name=hashtag_value]').val('');
      },
      error:function(xhr,textStatus,errorThrown){
        alert(xhr.responseText);
      }
    });
    return false;
  });
}
function toCode() {
  /*
    // If the set_aside is not defined then make the appearance of the entry convey that.
    $('a.btnSetAside').last().data('item_id', post.id);
    if(post.set_aside == undefined){
      $('a.btnSetAside').last().html('Save');
      $('a.btnSetAside').last().data('set_aside_id', '');
      $('img.saved').last().removeClass('saved');
    }else{
      $('a.btnSetAside').last().data('set_aside_id', post.set_aside.id);
      $('a.btnSetAside').last().html('Un-Save');
      $('div.entry').last().addClass('saved');
    }

  }
  // Add a click listener to Save/Un-Save item
  $('a.[class^=btn]').live('click', function(e){
    e.preventDefault(); // Keeps from invoking the href="#" of the anchor tag after the ajax completes
    _this = $(this);
    if($(_this).data('set_aside_id') == ''){
      // set_aside doesn't exist so create it
      $.ajax({
        url: '/set_asides',
        type: 'POST',
        data:  'item_id=' + $(_this).data('item_id'),
        success: function(post){
          $(_this).closest('div.entry').addClass('saved');
          $(_this).html('Un-Save');
          $(_this).data('set_aside_id', post.set_aside.id);
        }
      });
    }else{
      // set_aside exists so delete it
      $.ajax({
        url: '/set_asides/items/' + $(_this).data('set_aside_id') + '/delete',
        type: 'POST',
        success: function(rsp){
          $(_this).closest('div.entry').removeClass('saved');
          $(_this).html('Save');
          $(_this).data('set_aside_id', '');
        }
      });
    }
  });

   */
}

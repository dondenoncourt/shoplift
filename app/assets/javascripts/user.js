$(document).ready(function() {

  $('.onLink, .offLink').live('click', function () {
    alert('Coming Soon!');
    return false;
  });

  $('#user_biography').keyup(function () {
    setBioCount();
  });

  $('#fileupload').fileupload({
    dataType: 'json',
    add: function (e, data) {
      $('#avatar_thumb').replaceWith('<div style="width:70px;height:70px;float:left"><img alt="Loading" src="/assets/loading.gif" /></div>');
      data.submit();
    },
    done: function (e, data) {
      window.location.reload();
    }
  });

  // We'd like to load shoplifter followee suggestions with ajax but that doesn't play nice with pageless.js
  // $('.suggestions').live('click', function () {
  //   $('li.current').removeClass('current');
  //   $(this).parent().addClass('current');
  //   $.get(this.href, function(data, textStatus, xhr) {
  //     $('#rightCol').html(data);
  //   });
  //   return false;
  // });

});

function setBioCount() {
  if ($('#user_biography').length > 0) {
    $('.characterCount').html(110-($('#user_biography').val().length)+' Characters Left');
  };
}

function handleFollow(user_id, link) {
  if (link.text() == 'Follow') {
    followUser(user_id, link);
  } else {
    unfollowUser(user_id, link);
  };
}

function followUser(user_id, link) {
  $.ajax({
    url:'/subscriptions',
    type:'POST',
    data: { user_id: user_id },
    dataType:'json',
    success:function(data) {
      link.text("Unfollow");
    },
    error:function(xhr,textStatus,errorThrown){
      alert(errorThrown);
    }
  });
}

function unfollowUser(user_id, link) {
  $.ajax({
    url:'/subscriptions/users/' + user_id,
    type:'DELETE',
    dataType:'json',
    success:function(data) {
      link.text("Follow");
    },
    error:function(xhr,textStatus,errorThrown){
      alert('Error: ' + errorThrown);
    }
  });
}
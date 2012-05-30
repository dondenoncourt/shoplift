$(document).ready(function() {

  $('.onLink, .offLink').click(function () {
    alert('To Be Implemented');
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

});

function setBioCount() {
  if ($('#user_biography').length > 0) {
    $('.characterCount').html(110-($('#user_biography').val().length)+' Characters Left');
  };
}
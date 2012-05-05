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

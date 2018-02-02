import _ from './validation'
import _ from './templates'
window.current_date_time = new Date().toJSON().slice(0, 10) + " 00:00";

window.delete_listing = function(listing_id) {
  if (confirm("Are you sure you want to remove this time and all associated tickets?")) {
    $("#row_" + listing_id).remove();
    $("#tickets_" + listing_id).remove();
  }  
}

window.add_ticket = function(item) {
  var iterator = parseInt($(item).data("iterator"));
  $("#tickets_0 .ticket_row").length



  var current_ticket_count = parseInt($(item).data("ticket-count"));
  console.log("current_ticket_count = " + current_ticket_count);

  var detail = window.ticket_template({
    ticket_count: iterator + "_" + current_ticket_count
  });

  $(item).data("ticket-count", current_ticket_count + 1);
  $("#tickets_" + iterator).append(detail);
}

window.toggle_ticket_settings = function(ticket_counter_id) {
  console.log("toggle_ticket_settings -> " + ticket_counter_id);
  $("#row_ticket_settings_" + ticket_counter_id).toggle();
}

window.delete_ticket = function(ticket_counter_id) {
  console.log("delete_ticket -> " + ticket_counter_id);
  $("#row_ticket_settings_" + counter).remove();
  $("#row_ticket_" + counter).remove();
}
$(function () {
  window.add_listing_template();
});
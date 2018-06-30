
window.ticket_template = require("./templates/ticket_template.handlebars");
window.listing_template = require("./templates/listing_template.handlebars");

window.add_listing_template = function () {
  var listing_template_length = $(".listing_template").length;
  var html = window.listing_template({ listing_counter: listing_template_length });
  $("#listing_times").append(html);
  window.setup_date_pickers();

  if (window.class_id != undefined) {
    $(".delete_time").hide();
  }
}
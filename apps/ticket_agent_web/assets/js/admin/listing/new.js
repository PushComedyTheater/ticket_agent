import validation from './validation'
import templates from './templates'
import serializer from './serializer'

window.current_date_time = new Date().toJSON().slice(0, 10) + " 00:00";

window.delete_listing = function(listing_id) {
  if (confirm("Are you sure you want to remove this time and all associated tickets?")) {
    $("#row_" + listing_id).remove();
    $("#tickets_" + listing_id).remove();
  }  
}

window.add_ticket = function(item) {
  var iterator = parseInt($(item).data("iterator"));
  var current_ticket_count = $("#tickets_" + iterator + " .ticket_row").length;
  console.log("add_ticket -> " + iterator + " / " + current_ticket_count);
  
  var detail = window.ticket_template({
    iterator: iterator,
    current_ticket_count: current_ticket_count,
    ticket_name: "TEST - REMOVE",
    ticket_quantity: 80,
    ticket_price: 100
  });

  $(item).data("ticket-count", current_ticket_count + 1);
  $("#tickets_" + iterator).append(detail);
  $(":input").inputmask();
  window.setup_date_pickers();
}

window.toggle_ticket_settings = function(ticket_counter_id) {
  console.log("toggle_ticket_settings -> " + ticket_counter_id);
  $("#row_ticket_settings_" + ticket_counter_id).toggle();
}

window.delete_ticket = function(ticket_counter_id) {
  console.log("delete_ticket -> " + ticket_counter_id);
  $("#row_ticket_settings_" + ticket_counter_id).remove();
  $("#row_ticket_" + ticket_counter_id).remove();
}

window.copy_ticket = function(ticket_counter_id) {
  console.log("copy_ticket -> " + ticket_counter_id);
  var iterator = ticket_counter_id.split("_")[0];

  var values = {
    iterator: iterator,
    current_ticket_count: parseInt(ticket_counter_id.split("_")[1]) + 1,
    ticket_name: $("#ticket_name_" + ticket_counter_id).val(),
    ticket_quantity: $("#ticket_quantity_" + ticket_counter_id).val(),
    ticket_price: $("#ticket_price_" + ticket_counter_id).val()
  }

  var detail = window.ticket_template(values);
  $("#tickets_" + iterator).append(detail);
  $(":input").inputmask();
  window.setup_date_pickers();
}

window.setup_date_pickers = function () {
  console.log("setup_date_pickers");
  $('.listing_time').datetimepicker({
    format: 'yyyy-mm-dd hh:ii',
    showMeridian: true,
    autoclose: true,
    startDate: window.current_date_time,
    todayBtn: true
  }).on('changeDate', function (ev) {
    var target = $(ev.target);
    if (target.data("before")) {
      var before = target.data("before");
      $("#" + before).datetimepicker('setStartDate', target.val());
      $("#" + before).datetimepicker('setInitialDate', target.val());
    }
  });
}

window.create_class = function (e) {
  var valid_form = true;
  valid_form = window.validate_title(valid_form);
  valid_form = window.validate_description(valid_form);
  valid_form = window.validate_listings(valid_form);

  if (valid_form) {
    console.log("Loading up values");
    var details = {
      class_id: window.class_id,
      event_id: window.event_id,
      title: $("#listing_title").val(),
      description: window.load_description(),
      listings: window.load_listings()
    }
    console.log(details);

    $.ajax({
      // The URL for the request
      url: "/admin/listings",
      // The data to send (will be converted to a query string)
      data: JSON.stringify(details),
      // Whether this is a POST or GET request
      type: "POST",
      // The type of data we expect back
      contentType: "application/json",
      dataType: "json",
      // add in csrf_token
      beforeSend: function (xhr) {
        xhr.setRequestHeader("X-CSRF-Token", window.csrf_token);
      },
    }).done(function (response) {
      console.log("done");
      console.log(response);
    }).fail(function (xhr, status, errorThrown) {
      // Code to run if the request fails; the raw request and
      // status codes are passed to the function
      window.console.log("Received error creating order: ")
      window.console.log("errorThrown: " + errorThrown);
    });
  } else {
    console.log("Form is invalid");
  }
  e.preventDefault();
}


$(function () {
  window.add_listing_template();
  $("#create_class").on("click", function(e) {
    window.create_class(e);
  })
});
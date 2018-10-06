import validation from './validation'
import serializer from './serializer'

window.current_date_time = new Date().toJSON().slice(0, 10) + " 00:00";
window.setup_date_pickers = function () {
  console.log("setup_date_pickers")
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

window.update_it = function (e) {
  console.log("crea");
  var valid_form = true;
  valid_form = window.validate_title(valid_form);
  valid_form = window.validate_description(valid_form);
  valid_form = window.validate_listings(valid_form);

  if (valid_form) {
    var details = {
      title: $("#listing_title").val(),
      description: window.load_description(),
      image: $("#the_image").attr("src"),
      tickets: window.load_edit_tickets()
    };
    console.log(details);
    //   $.ajax({
    //     // The URL for the request
    //     url: "/admin/listings",
    //     // The data to send (will be converted to a query string)
    //     data: JSON.stringify(details),
    //     // Whether this is a POST or GET request
    //     type: "POST",
    //     // The type of data we expect back
    //     contentType: "application/json",
    //     dataType: "json",
    //     // add in csrf_token
    //     beforeSend: function beforeSend(xhr) {
    //       xhr.setRequestHeader("X-CSRF-Token", window.csrf_token);
    //     }
    //   }).done(function (response) {
    //     console.log("done");
    //     console.log(response); // window.location.href = "/admin/classes"
    //   }).fail(function (xhr, status, errorThrown) {
    //     // Code to run if the request fails; the raw request and
    //     // status codes are passed to the function
    //     window.console.log("Received error creating order: ");
    //     window.console.log("errorThrown: " + errorThrown);
    //   });
  } else {
    console.log("Form is invalid");
  }

  e.preventDefault();
};

$(function () {
  $(":input").inputmask();
  var start_time = $("#listing_start_time").val();
  start_time = moment.tz(start_time, "Europe/London").clone().tz("America/New_York").format('YYYY-MM-DD HH:mm');
  console.log(start_time);
  $("#listing_start_time").val(start_time);

  var end_time = $("#listing_end_time").val();
  end_time = moment.tz(end_time, "Europe/London").clone().tz("America/New_York").format('YYYY-MM-DD HH:mm');
  console.log(end_time);

  $("#listing_end_time").val(end_time);
  window.setup_date_pickers();
});

$("#create_it").on("click", function (e) {
  window.update_it(e);
})
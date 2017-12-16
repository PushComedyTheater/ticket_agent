window.reload_form = function() {
  window.load_details_from_cookie();
  window.load_attendee_forms();
  window.set_continue_button();
  window.set_total_price();
}

window.load_details_from_cookie = function() {
  var cookie_data = Cookies.get("ticket_data");
  if (cookie_data) {
    window.console_log("Resetting to cookie");
    window.details = JSON.parse(window.atob(cookie_data));
  } else {
    window.console_log("No cookie to reset to");
  }
}

window.save_details_to_cookie = function() {
  var encodedData = window.btoa(JSON.stringify(window.details));
  var inFifteenMinutes = new Date(new Date().getTime() + 15 * 60 * 1000);
  Cookies.set("ticket_data", encodedData, {expires: inFifteenMinutes});
}

window.load_attendee_forms = function() {
  var tickets  = window.details.tickets;
  var source   = $("#entry-template").html();
  window.attendee_template = Handlebars.compile(source);

  var output = "";

  for (var i = 0; i < tickets.length; i++) {
    var context = {count: i, count_string: i + 1, ticket: tickets[i]};
    var html    = window.attendee_template(context);
    output += html;
  }

  $("#attendee_form").html(output);
  $("#ticket_count").val(tickets.length);
}

window.set_continue_button = function() {
  var ticket_count = window.details.tickets.length;
  if (ticket_count == 1) {
    $("#logged_in_text").text("Reserve " + ticket_count + " Ticket As " + window.details.buyer_name);
  } else {
    $("#logged_in_text").text("Reserve " +ticket_count + " Tickets As " + window.details.buyer_name);
  }
}

window.set_total_price = function() {
  console.log(window.details.tickets.length);
  console.log(window.details.ticket_price);
  var total = (window.details.tickets.length * window.details.ticket_price).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
  $("#invoice_cost").html("$" + total);
}

window.save_ticket = function(counter) {
  var valid_form = true;
  var name = $("#attendee_name_" + counter).val();
  var email = $("#attendee_email_" + counter).val();

  if (name.length == 0) {
    // window.console_log("name is 0");
    $("#name_required_" + counter).show();
    $("#name_group_" + counter).addClass("u-has-error-v1");
    valid_form = false;
  } else {
    // window.console_log("name is not 0");
    $("#name_required_" + counter).hide();
    $("#name_group_" + counter).removeClass("u-has-error-v1");
  }

  if (email.length == 0) {
    // window.console_log("email is 0");
    $("#email_required_" + counter).show();
    $("#email_required_" + counter).html("This is a required field.");
    $("#email_group_" + counter).addClass("u-has-error-v1");
    valid_form = false;
  } else {
    // window.console_log("email is not 0");
    if (!$("#attendee_email_" + counter)[0].checkValidity()) {
      // window.console_log("email is not valid");
      $("#email_required_" + counter).show();
      $("#email_required_" + counter).html("Please use a valid email address.");
      $("#email_group_" + counter).addClass("u-has-error-v1");
      valid_form = false;
    } else {
      // window.console_log("email is valid");
      $("#email_required_" + counter).hide();
      $("#email_group_" + counter).removeClass("u-has-error-v1");
    }
  }

  window.details.tickets[counter] = {
    name: name,
    email: email,
    valid: valid_form
  }
  window.save_details_to_cookie();
  return valid_form;
}

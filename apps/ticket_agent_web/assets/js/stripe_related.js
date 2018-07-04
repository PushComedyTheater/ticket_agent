window.loading_token = false;

window.load_order_table = function() {
  var tickets  = window.details.tickets;
  var source   = $("#entry-template").html();
  window.attendee_template = Handlebars.compile(source);
  var source   = $("#calculated-template").html();
  window.calculated_template = Handlebars.compile(source);

  var output = "";

  var subtotal = 0;

  for (var i = 0; i < tickets.length; i++) {
    var ticket = tickets[i];
    var ticket_price = ticket.price;
    subtotal += ticket_price;
    var context = {
      group: ticket.group,
      ticket_name: ticket.ticket_name,
      name: ticket.name,
      price: (ticket_price / 100).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
    };
    var html    = window.attendee_template(context);
    output += html;
  }
  var pricing = window.details.pricing;

  if (window.details.pass_fees) {
    var subtotal = (pricing.subtotal / 100).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
    output += window.calculated_template({
      title: "Subtotal",
      value: "$" + subtotal
    })

    var processing_fee = (pricing.processing_fee / 100).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
    output += window.calculated_template({
      title: "Processing Fee",
      value: "$" + processing_fee
    })
  }

  var total = (pricing.total / 100).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
  $("#submit_button").html("Submit Payment For $" + total);
  output += window.calculated_template({title: "Total", value: "$" + total})
  $("#ticket_body").html(output);
}

window.reserve_tickets = function () {
  window.console_group("reserve_tickets");
  window.console_log("Reserving tickets");
  $("#ticket_bar").css("width", "60%");

  $.ajax({
    // The URL for the request
    url: "/orders",
    // The data to send (will be converted to a query string)
    data: JSON.stringify(window.details),
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
    $("#ticket_bar").css("width", "90%");
    window.console_log("Reserved tickets successfully with response: ");
    window.console_log(response);

    window.details.locked_until = response.locked_until;
    window.details.order_id     = response.order_slug;
    window.details.tickets      = response.tickets;
    window.details.pricing      = response.pricing;
    window.details.pass_fees    = response.pass_fees;

    window.load_order_table();
    //window.console_group("setting countdown")
    var user_time_zone = moment.tz.guess();
    // window.console_log("user_time_zone = " + user_time_zone);
    //
    var locked_until_utc = moment.tz(response.locked_until, "UTC");
    // //window.console_log("locked_until_utc = " + locked_until_utc.format("YYYY/MM/DD HH:mm:ss"));
    //
    var locked_until_user_tz = locked_until_utc.clone().tz(user_time_zone);
    // //window.console_log("locked_until_user_tz = " + locked_until_user_tz.format("YYYY/MM/DD HH:mm:ss"));
    //
    var now = moment().tz(user_time_zone);
    // //window.console_log("now = " + now.format("YYYY/MM/DD HH:mm:ss"));
    //
    var difference_from_now = locked_until_user_tz.diff(now);
    // //window.console_log("difference_from_now = " + difference_from_now);
    //
    if (difference_from_now > 0) {
      //window.console_log("they still have time " + difference_from_now);
      var until = locked_until_user_tz.format("YYYY/MM/DD HH:mm:ss");
      $("#locked_until").countdown(
        until,
        function (event) {
          $(this).text(event.strftime('%M:%S'));
        }
      ).on(
        'finish.countdown',
        function (event) {
          window.release_tickets(true);
        }
        );
    } else {
      window.release_tickets(true);
    }
    // //window.console_group_end();
    // //window.console_group_end();
    window.setup_payment_request_button("#payment-request-button");

    $("#ticket_bar").css("width", "100%");

    window.setTimeout(function () { Custombox.modal.close(); }, 25);
  }).fail(function (xhr, status, errorThrown) {
    // Code to run if the request fails; the raw request and
    // status codes are passed to the function
    //window.console_log("Received error creating order: ")
    //window.console_log("errorThrown: " + errorThrown);
  });
}

window.release_tickets = function (redirect) {
  // window.console_dir("releasing tickets with redirect: " + redirect);
  $.ajax({
    // The URL for the request
    url: "/orders/push.json",
    // The data to send (will be converted to a query string)
    data: JSON.stringify(window.details),
    // Whether this is a POST or GET request
    type: "DELETE",
    // The type of data we expect back
    contentType: "application/json",
    dataType: "json",
    // add in csrf_token
    beforeSend: function (xhr) {
      xhr.setRequestHeader("X-CSRF-Token", window.csrf_token);
    },
  }).done(function (json) {
    //window.console_log("Response successful");
    // Code to run if the request succeeds (is done);
    // The response is passed to the function
    //window.console_dir(json);
    ////window.console_group_end();
    if (redirect) {
      window.removeEventListener("beforeunload", window.unloader);
      var location = "";
      if (window.details.listing.type == "class") {
        location = "/class/" + window.details.listing.class_slug + "?msg=cancelled_order"
      } else {
        location = "/events/" + window.details.listing.slug + "?msg=cancelled_order"
      }
      window.location.href = location;
    }
  }).fail(function (xhr, status, errorThrown) {
    // Code to run if the request fails; the raw request and
    // status codes are passed to the function
    window.console_error("Received error creating order: ")
    window.console_error("errorThrown: " + errorThrown);
    //window.console_group_end();
    window.removeEventListener("beforeunload", window.unloader);
    window.location.href = "/events/" + window.details.listing.slug + "?msg=cancelled_order"
  });

}

window.stripeTokenHandler = function (result, ev) {
  //window.console_log("We got a token");
  //window.console_log(result);
  var stripeValues = window.parse_stripe_response(result);
  // //window.console_log("loading window values and concating");
  var values = $.extend({}, window.details, stripeValues);

  window.send_token_for_charge(values, ev);
}

window.send_token_for_charge = function (values, ev) {
  //window.console_group("send_token_for_charge");
  $.ajax({
    // The URL for the request
    url: "/charges",
    // The data to send (will be converted to a query string)
    data: JSON.stringify(values),
    // Whether this is a POST or GET request
    type: "POST",
    // The type of data we expect back
    contentType: "application/json",
    dataType: "json",
    // add in csrf_token
    beforeSend: function (xhr) {
      xhr.setRequestHeader("X-CSRF-Token", window.csrf_token);
    },
  }).done(function (json) {
    // //window.console_log("Response successful from our server");
    // Code to run if the request succeeds (is done);
    // The response is passed to the function
    if (ev && ev.complete) {
      ev.complete("success");
    }
    $("#submit_button").html("Redirecting....");
    // //window.console_group_end();
    window.removeEventListener("beforeunload", window.unloader);
    window.location.href = "/orders/" + window.details.order_id;
  }).fail(function (xhr, status, errorThrown) {
    if (ev && ev.complete) {
      ev.complete("fail");
    }
    $("#card_error").show()
    $("#card_error").html(errorThrown);

    if (xhr && xhr.responseJSON) {
      var response = xhr.responseJSON;
      $("#card_error").html(response.reason);

      if (response.code == "reset") {
        window.removeEventListener("beforeunload", window.unloader);
        window.location.href = "/events/" + window.details.listing.slug + "?msg=tickets_gone"
      }
    }
    window.loading_token = false;
    $("#submit_button").html(window.old_submit_text);
    $("#submit_button").css("disabled", "");
  });
}

window.generate_payment_request_button = function() {
  var items = $.map(window.details.tickets, function (val, i) {
    return {
      label: "Ticket For " + val.name,
      amount: val.price
    }
  });

  if (window.details.pass_fees) {
    items.push({
      label: "Processing Fee",
      amount: window.details.pricing.processing_fee
    });
  }



  return window.stripe_instance.paymentRequest({
    country: 'US',
    currency: 'usd',
    requestPayerName: true,
    requestPayerPhone: true,
    requestPayerEmail: true,
    total: {
      label: "Total for ticket(s)",
      amount: window.details.pricing.total,
      },
    displayItems: items,
  });
}

window.setup_payment_request_button = function(div_id) {
  var paymentRequest = window.generate_payment_request_button();

  var payment_request_button = window.stripe_elements.create('paymentRequestButton', {
    paymentRequest: paymentRequest,
  });

  paymentRequest.canMakePayment().then(function (result) {
    if (result) {
      payment_request_button.mount(div_id);
    } else {
      $("#payment-request-button").hide();
    }
  });

  paymentRequest.on('token', function (ev) {
    // //window.console_group("paymentRequest.on.token")
    // //window.console_log("parsing stripe response");
    var stripeValues = window.parse_stripe_response(ev);
    // //window.console_log("loading window values and concating");
    var values = $.extend({}, window.details, stripeValues);
    // //window.console_dir(values);
    window.send_token_for_charge(values, ev);
  });
}

window.setup_card_number = function(div_id) {
  window.card_number = window.stripe_elements.create("cardNumber", {});
  window.card_number.mount(div_id);
  window.card_number.on("change", function (event) {
    if (event.error) {
      $("#card_error").show()
      $("#card_error").html(event.error.message);
    }
    if (event.complete) {
      $("#card_error").hide()
    }
  });
}

window.setup_card_expiry = function(div_id) {
  window.card_expiry = window.stripe_elements.create('cardExpiry', {});
  window.card_expiry.mount(div_id);
  window.card_expiry.on("change", function (event) {
    if (event.error) {
      $("#card_error").show()
      $("#card_error").html(event.error.message);
    }
    if (event.complete) {
      $("#card_error").hide()
    }
  });
}

window.setup_card_cvc = function(div_id) {
  window.card_cvc = window.stripe_elements.create('cardCvc', {});
  window.card_cvc.mount(div_id);
  window.card_cvc.on("change", function (event) {
    if (event.error) {
      $("#card_error").show()
      $("#card_error").html(event.error.message);
    }
    if (event.complete) {
      $("#card_error").hide()
    }
  });
}

window.setup_submit_button = function(div_id) {
  $(div_id).on("submit", function (ev) {
    ev.preventDefault();
    $("#card_error").hide();
    window.old_submit_text = $("#submit_button").html();
    $("#submit_button").html("Processing....");
    $("#submit_button").css("disabled", "disabled");

    if (window.loading_token) {
      return false;
    }

    window.loading_token = true;

    var card_zip = $("#card_zip").val().trim();

    if (card_zip.length >= 5) {
      var additional_data = {
        name: window.details.buyer_name,
        address_zip: $("#card_zip").val()
      };

      window.stripe_instance.createToken(window.card_number, additional_data).then(function (result) {
        if (result.error) {
          $("#submit_button").html(window.old_submit_text);
          $("#card_error").show()
          $("#card_error").html(result.error.message);
          window.loading_token = false;
        } else {
          window.stripeTokenHandler(result, ev);
        }
      });
    } else {
      window.loading_token = false;
      $("#card_error").show();
      $("#submit_button").html(window.old_submit_text);
      $("#card_error").html("Please enter a valid zip code.");
    }
  })
}

$(document).on('ready', function () {
  window.reserve_tickets();

  $("#cancel_button").on("click", function(e) {
    e.preventDefault();
    window.release_tickets(true);
  });
  window.stripe_instance = Stripe(window.stripe_publishable_key);
  window.stripe_elements = window.stripe_instance.elements();
  window.setup_card_number("#card-number");
  window.setup_card_expiry("#card-expiry");
  window.setup_card_cvc("#card-cvc");
  window.setup_submit_button("#payment-form");
});

window.unloader = function(e) {
  var confirmationMessage = "\o/";

  e.returnValue = confirmationMessage;     // Gecko, Trident, Chrome 34+
  return confirmationMessage;              // Gecko, WebKit, Chrome <34
}

window.addEventListener("beforeunload", window.unloader);

window.reserve_tickets = function () {
  //window.console_group("reserve_tickets");
  //window.console_log("Reserving tickets");
  var values = window.load_window_values();
  $("#ticket_bar").css("width", "60%");

  $.ajax({
    // The URL for the request
    url: "/orders",
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
  }).done(function (response) {
    $("#ticket_bar").css("width", "90%");

    //window.console_log("Reserved tickets successfully with response: ");
    //window.console_dir(response);
    
    window.order_id = response.slug;
    window.tickets  = response.tickets;

    //window.console_group("setting countdown")
    var user_time_zone = moment.tz.guess();
    //window.console_log("user_time_zone = " + user_time_zone);

    var locked_until_utc = moment.tz(response.locked_until, "UTC");
    //window.console_log("locked_until_utc = " + locked_until_utc.format("YYYY/MM/DD HH:mm:ss"));

    var locked_until_user_tz = locked_until_utc.clone().tz(user_time_zone);
    //window.console_log("locked_until_user_tz = " + locked_until_user_tz.format("YYYY/MM/DD HH:mm:ss"));

    var now = moment().tz(user_time_zone);
    //window.console_log("now = " + now.format("YYYY/MM/DD HH:mm:ss"));

    var difference_from_now = locked_until_user_tz.diff(now);
    //window.console_log("difference_from_now = " + difference_from_now);

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
          window.release_tickets();
        }
        );
    } else {
      window.release_tickets();
    }
    //window.console_group_end();
    //window.console_group_end();
    $("#ticket_bar").css("width", "100%");
    window.setTimeout(function () { Custombox.modal.close(); }, 25);
  }).fail(function (xhr, status, errorThrown) {
    // Code to run if the request fails; the raw request and
    // status codes are passed to the function
    //window.console_log("Received error creating order: ")
    //window.console_log("errorThrown: " + errorThrown);
  });
}

window.release_tickets = function () {
  var values = window.load_window_values();
  $.ajax({
    // The URL for the request
    url: "/orders/push.json",
    // The data to send (will be converted to a query string)
    data: JSON.stringify(values),
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
    window.location.href = "/events/" + window.show_id + "?msg=released_tickets"
  }).fail(function (xhr, status, errorThrown) {
    // Code to run if the request fails; the raw request and
    // status codes are passed to the function
    window.console_error("Received error creating order: ")
    window.console_error("errorThrown: " + errorThrown);
    //window.console_group_end();
    window.location.href = "/events/" + window.show_id + "?msg=released_tickets"
  });  
  
}

window.load_window_values = function () {
  return {
    email: window.buyer_email,
    name: window.buyer_name,
    guest_checkout: window.guest_checkout,
    order_id: window.order_id,
    listing_id: window.listing_id,
    total_price: window.total_price,
    tickets: window.tickets
  }
}

window.stripeTokenHandler = function (result, ev) {
  //window.console_log("We got a token");
  //window.console_log(result);
  console.log(window.parse_stripe_response(result));
  var values = $.extend({}, window.load_window_values(), result);
  console.log(values);
  send_token_for_charge(result, ev);
}

window.send_token_for_charge = function (values, ev) {
  // //window.console_group("send_token_for_charge");
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
    
    //window.console_dir(json);
    // //window.console_group_end();
  }).fail(function (xhr, status, errorThrown) {
    if (ev && ev.complete) {
      ev.complete("fail");
    }
    // window.console_error("Received error creating order: ")
    // window.console_error("errorThrown: " + errorThrown);
    // //window.console_group_end();
  });
} 

window.generate_payment_request_button = function() {
  var items = $.map(window.tickets, function (val, i) {
    return {
      label: "Ticket For " + val.name,
      amount: window.ticket_price
    }
  });  
  return window.stripe_instance.paymentRequest({
    country: 'US',
    currency: 'usd',
    requestPayerName: true,
    requestPayerPhone: true,
    requestPayerEmail: true,
    total: {
      label: "Total for ticket(s)",
      amount: window.total_price,
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
    var values = $.extend({}, window.load_window_values(), stripeValues);
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
  });
}

window.setup_submit_button = function(div_id) {
  $(div_id).on("submit", function (ev) {
    ev.preventDefault();

    var additional_data = {
      name: window.buyer_name,
      address_zip: $("#card_zip").val()
    };

    window.stripe_instance.createToken(window.card_number, additional_data).then(function (result) {
      if (result.error) {
        // Inform the user if there was an error
        //window.console_log("There was an error:");
        //window.console_log(result.error);
      } else {
        // Send the token to your server
        console.log("SEND TOKEN");
        console.log(result);
        window.stripeTokenHandler(result, ev);

      }
    });

  })  
}

$(document).on('ready', function () {
  window.reserve_tickets();
  window.stripe_instance = Stripe(window.stripe_publishable_key);
  window.stripe_elements = window.stripe_instance.elements();
  
  window.setup_payment_request_button("#payment-request-button");
  window.setup_card_number("#card-number");
  window.setup_card_expiry("#card-expiry");
  window.setup_card_cvc("#card-cvc");
  window.setup_submit_button("#payment-form");
});
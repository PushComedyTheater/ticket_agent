import "phoenix_html"
import { Socket } from "phoenix";

let socket = new Socket("/socket", {params: {token: window.session_token}})
socket.connect()

let channel = socket.channel("listing:" + window.listing_id, {token: window.session_token})
channel.on("new_msg", msg => console.log("Got message", msg) )

channel.join()
  .receive("ok", (tickets) => {
    console.log("catching up", tickets);
    load_items(tickets);
  }).receive("error", ({reason}) => console.log("failed join", reason) )
  .receive("timeout", () => console.log("Networking issue. Still waiting..."))

channel.on("change", ticket => {
  $("#" + ticket.id).attr("checked", "checked");
  console.log("Change:", ticket);
});

function setupOnload() {
  $(".checkin").on("click", function(e) {
    var details = {
      ticket_id: $(this).data("ticket-id")
    }
    $.ajax({
      // The URL for the request
      url: "/concierge/checkin",
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
    }).done(function (json) {
      window.console_log("Response successful");
      // Code to run if the request succeeds (is done);
      // The response is passed to the function
      window.console_dir(json);
    }).fail(function (xhr, status, errorThrown) {
      // Code to run if the request fails; the raw request and
      // status codes are passed to the function
      window.console_error("Received error creating order: ")
      window.console_error("errorThrown: " + errorThrown);
      //window.console_group_end();
    });

  });
}

function load_items(tickets) {
  let ticket_template = $("#ticket_template").html();
  let source = Handlebars.compile(ticket_template);
  var output = "";
  //
  for (var i = 0; i < tickets.length; i++) {
    var ticket = tickets[i];
    var html    = source(ticket);
    output += html;
  }
  $("#ticket_body").html(output);
  setupOnload();
}

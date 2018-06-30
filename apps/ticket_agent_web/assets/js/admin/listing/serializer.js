window.random = new Random(Random.engines.mt19937().seedWithArray([0x12345678, 0x90abcdef]));

window.load_description = function (valid_form) {
  var ck_instance = CKEDITOR.instances["listing_description"].editable();
  if (ck_instance) {
    return ck_instance.getText();
  }
  return "";
}

window.load_listings = function () {
  var template_count = $(".listing_template").length;
  var listings = [];

  for (var i = 0; i < template_count; i++) {
    listings.push(window.load_listing(i));
  }
  return listings;
}

window.load_listing = function(i) {
  var start_time = $("#listing_start_time_" + i).val();
  start_time = moment.tz(start_time, "America/New_York").clone().tz("Europe/London").format();

  var end_time = $("#listing_end_time_" + i).val();
  if (end_time.length > 0) {
    end_time = moment.tz(end_time, "America/New_York").clone().tz("Europe/London").format();
  }

  return {
    slug: window.random.hex(10),
    start_time: start_time,
    end_time: end_time,
    tickets: window.load_tickets(i)
  }
}

window.load_tickets = function(i) {
  var ticket_count = parseInt($("#add_ticket_" + i).data("ticket-count"));
  var current_ticket_count = $("#tickets_" + i + " .ticket_row").length;
  console.log("ticket_count " + ticket_count);
  console.log("current_ticket_count " + current_ticket_count);
  var tickets = []
  console.log("there are " + ticket_count + " tickets");

  for (var j = 0; j < ticket_count; j++) {
    console.log("load_tickets -> checking ticket " + i + "_" + j);

    var sale_start = $("#listing_start_time_" + i + "_" + j).val();
    if (sale_start.length > 0) {
      sale_start = moment.tz(sale_start, "America/New_York").clone().tz("Europe/London").format();
    }

    var sale_end = $("#listing_end_time_" + i + "_" + j).val();
    if (sale_end.length > 0) {
      sale_end = moment.tz(sale_end, "America/New_York").clone().tz("Europe/London").format();
    }

    tickets.push({
      name: $("#ticket_name_" + i + "_" + j).val(),
      description: $("#ticket_description_" + i + "_" + j).val(),
      group: window.random.hex(15),
      quantity:  parseInt($("#ticket_quantity_" + i + "_" + j).val()),
      price: parseInt($("#ticket_price_" + i + "_" + j).val().replace("$ ", "").replace(".", "")),
      pass_fees: $("#ticket_fees_" + i + "_" + j).prop("checked"),
      sale_start: sale_start,
      sale_end: sale_end,
    })
  }
  return tickets;
}

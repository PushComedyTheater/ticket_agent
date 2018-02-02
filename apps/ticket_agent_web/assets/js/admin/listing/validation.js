
window.validate_title = function (valid_form) {
  if ($("#listing_title").val().length == 0) {
    valid_form = false;
    $("#listing_title_error").show();
    $("#listing_title_group").addClass("has-error");
    $("#listing_title").focus();
  } else {
    $("#listing_title_error").hide();
    $("#listing_title_group").removeClass("has-error");
  }
  return valid_form;
}

window.validate_description = function (valid_form) {
  var ck_instance = CKEDITOR.instances["listing_description"].editable();
  if (ck_instance) {
    var listing_description = ck_instance.getText();
    if (listing_description.length <= 1) {
      valid_form = false;
      $("#listing_description_error").show();
      $("#listing_description_group").addClass("has-error");
    } else {
      $("#listing_description_error").hide();
      $("#listing_description_group").removeClass("has-error");
    }
  }
  return valid_form;
}

window.validate_listings = function (valid_form) {
  var template_count = $(".listing_template").length;

  for (var i = 0; i < template_count; i++) {
    valid_form = window.validate_listing(i, valid_form);
  }
  return valid_form;
}

window.validate_listing = function (i, valid_form) {
  var start_time = $("#listing_start_time_" + i).val();
  var end_time = $("#listing_end_time_" + i).val();

  if (start_time.length == 0) {
    $("#listing_start_time_group_" + i).addClass("has-error");
    $("#listing_start_time_error_" + i).show();
    valid_form = false;
  } else {
    $("#listing_start_time_group_" + i).removeClass("has-error");
    $("#listing_start_time_error_" + i).hide();
  }

  if (end_time.length > 0) {
    var start_time = new Date(start_time);
    var end_time = new Date(end_time);

    if (start_time >= end_time) {
      valid_form = false;
      $("#listing_time_error_" + i).show();
      $("#row_" + i).addClass("has-error");
    } else {
      $("#listing_time_error_" + i).hide();
      $("#row_" + i).removeClass("has-error");
    }
  }

  var ticket_count = parseInt($("#add_ticket_" + i).data("ticket-count"));

  if (ticket_count == 0) {
    $("#ticket_missing_" + i).show();
    valid_form = false;
  } else {
    for (var j = 0; j < ticket_count; j++) {
      var ticket_name = $("#ticket_name_" + i + "_" + j).val();
      var ticket_quantity = $("#ticket_quantity_" + i + "_" + j).val();
      var ticket_price = $("#ticket_price_" + i + "_" + j).val();
      console.log(ticket_name);
      console.log(ticket_quantity);
      console.log(ticket_price);
    }
  }
  return valid_form;
}
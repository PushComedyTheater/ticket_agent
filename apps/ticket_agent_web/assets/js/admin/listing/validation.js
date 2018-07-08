window.validate_title = function (valid_form) {
  console.log("validate_title");
  if ($("#listing_title").val().length == 0) {
    console.log("validate_title->not cool");
    valid_form = false;
    $("#listing_title_error").show();
    $("#listing_title_group").addClass("has-error");
    $("#listing_title").focus();
  } else {
    console.log("validate_title->cool");
    $("#listing_title_error").hide();
    $("#listing_title_group").removeClass("has-error");
  }
  return valid_form;
}

window.validate_description = function (valid_form) {
  console.log("validate_description");
  var ck_instance = CKEDITOR.instances["listing_description"].editable();
  if (ck_instance) {
    var listing_description = ck_instance.getText();
    if (listing_description.length <= 1) {
      console.log("validate_description->not cool");
      valid_form = false;
      $("#listing_description_error").show();
      $("#listing_description_group").addClass("has-error");
    } else {
      console.log("validate_description->cool");
      $("#listing_description_error").hide();
      $("#listing_description_group").removeClass("has-error");
    }
  }
  return valid_form;
}

window.validate_listings = function (valid_form) {
  console.log("validate_listings")
  var template_count = $(".listing_template").length;

  for (var i = 0; i < template_count; i++) {
    valid_form = window.validate_listing(i, valid_form);
  }
  return valid_form;
}

window.validate_listing = function (i, valid_form) {
  console.log("validate_listing->" + i);
  var start_time = $("#listing_start_time_" + i).val();
  var end_time = $("#listing_end_time_" + i).val();

  if (start_time.length == 0) {
    console.log("validate_listing->" + i + ": no start_time");
    $("#listing_start_time_group_" + i).addClass("has-error");
    $("#listing_start_time_error_" + i).show();
    valid_form = false;
  } else {
    console.log("validate_listing->" + i + ": start_time is cool");
    $("#listing_start_time_group_" + i).removeClass("has-error");
    $("#listing_start_time_error_" + i).hide();
  }

  if (end_time.length > 0) {
    console.log("validate_listing->" + i + ": end_time is there, lets check");
    $("#listing_end_time_group_" + i).removeClass("has-error");
    $("#listing_end_time_error_" + i).hide();

    var start_time = new Date(start_time);
    var end_time = new Date(end_time);

    if (start_time >= end_time) {
      console.log("validate_listing->" + i + ": end time is somehow before start_time");
      valid_form = false;
      $("#listing_time_error_" + i).show();
      $("#row_" + i).addClass("has-error");
    } else {
      console.log("validate_listing->" + i + ": end time is cool");
      $("#listing_time_error_" + i).hide();
      $("#row_" + i).removeClass("has-error");
    }
  }

  var ticket_count = $("#tickets_" + i + " .ticket_row").length;

  if (ticket_count == 0) {
    console.log("validate_listing->" + i + ": no tickets");
    $("#ticket_missing_" + i).show();
    valid_form = false;
  } else {
    console.log("validate_listing->" + i + ": we have tickets");
    var used_names = [];
    $("#ticket_missing_" + i).hide();
    console.log("validate_listing->" + i + ": checking tickets");
    for (var j = 0; j < ticket_count; j++) {
      console.log("validate_listing->" + i + "/" + j + ": checking ticket");


      var ticket_name        = $("#ticket_name_" + i + "_" + j).val();
      var ticket_quantity    = parseInt($("#ticket_quantity_" + i + "_" + j).val());
      var ticket_price       = parseInt($("#ticket_price_" + i + "_" + j).val().replace("$ ", "").replace(".", ""));
      var ticket_description = $("#ticket_description_" + i + "_" + j).val();
      var start_time         = $("#listing_start_time_" + i + "_" + j).val();
      var end_time           = $("#listing_end_time_" + i + "_" + j).val();

      if (ticket_name.length == 0) {
        console.log("validate_listing->" + i + "/" + j + ": ticket name is too short");
        $("#ticket_name_" + i + "_" + j + "_error").show();
        $("#ticket_name_" + i + "_" + j + "_group").addClass("has-error");
        $("#ticket_name_" + i + "_" + j).focus();
        valid_form = false;
      } else {
        console.log("validate_listing->" + i + "/" + j + ": ticket name (" + ticket_name + ") is not too short");
        console.log("used_names = ");
        console.table(used_names);
        if ($.inArray(ticket_name, used_names) >= 0) {
          console.log("validate_listing->" + i + "/" + j + ": ticket name is in list of used names");
          console.log(used_names);
          $("#ticket_name_used_" + i + "_" + j + "_error").show();
          $("#ticket_name_" + i + "_" + j + "_group").addClass("has-error");
          $("#ticket_name_" + i + "_" + j).focus();
          valid_form = false;
        } else {
          console.log("validate_listing->" + i + "/" + j + ": ticket name not used");
          $("#ticket_name_used_" + i + "_" + j + "_error").hide();
          $("#ticket_name_" + i + "_" + j + "_group").removeClass("has-error");
          used_names.push(ticket_name);
        }
      }

      if (ticket_quantity == 0) {
        console.log("validate_listing->" + i + "/" + j + ": ticket_quantity is 0");
        $("#ticket_quantity_" + i + "_" + j + "_error").show();
        $("#ticket_quantity_" + i + "_" + j + "_group").addClass("has-error");
        $("#ticket_quantity_" + i + "_" + j).focus();
        valid_form = false;
      } else {
        console.log("validate_listing->" + i + "/" + j + ": ticket quantity is greater than zero");
        $("#ticket_quantity_" + i + "_" + j + "_error").hide();
        $("#ticket_quantity_" + i + "_" + j + "_group").removeClass("has-error");
      }

      if (ticket_price == 0) {
        if (confirm("Are you sure you want to make this ticket free?")){
          console.log("validate_listing->" + i + "/" + j + ": ticket_price is okay to be 0");
          $("#ticket_price_" + i + "_" + j + "_error").hide();
          $("#ticket_price_" + i + "_" + j + "_group").removeClass("has-error");
        } else {
          console.log("validate_listing->" + i + "/" + j + ": ticket_price is 0");
          $("#ticket_price_" + i + "_" + j + "_error").show();
          $("#ticket_price_" + i + "_" + j + "_group").addClass("has-error");
          $("#ticket_price_" + i + "_" + j).focus();
          valid_form = false;
        }


      } else {
        console.log("validate_listing->" + i + "/" + j + ": ticket_price is > 0");
        $("#ticket_price_" + i + "_" + j + "_error").hide();
        $("#ticket_price_" + i + "_" + j + "_group").removeClass("has-error");
      }
    }
  }
  return valid_form;
}

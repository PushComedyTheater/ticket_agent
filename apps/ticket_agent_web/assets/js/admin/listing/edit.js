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

$(function () {
  $(":input").inputmask();
  var start_time = $("#listing_start_time").val();
  start_time = moment.tz(start_time, "Europe/London").clone().tz("America/New_York").format('YYYY-MM-DD hh:mm');
  $("#listing_start_time").val(start_time);

  var end_time = $("#listing_end_time").val();
  console.log(end_time);
  end_time = moment.tz(end_time, "Europe/London").clone().tz("America/New_York").format('YYYY-MM-DD hh:mm');
  $("#listing_end_time").val(end_time);
  window.setup_date_pickers();
});
$("a.tagger").on("click", function() {
  selected = $(this).data("selected");
  if (selected) {
    $(this).data("selected", false);
    $(this).removeClass("g-bg-gray-dark-v2").removeClass("g-brd-gray-dark-v2").removeClass("g-color-white");
    $(this).addClass("g-bg-gray-dark-v2--hover").addClass("g-brd-gray-dark-v2--hover").addClass("g-color-white--hover");
  } else {
    $(this).data("selected", true);
    $(this).addClass("g-bg-gray-dark-v2").addClass("g-brd-gray-dark-v2").addClass("g-color-white");
    $(this).removeClass("g-bg-gray-dark-v2--hover").removeClass("g-brd-gray-dark-v2--hover").removeClass("g-color-white--hover");
  }

  $("article").hide();
  $("#aggregated_tags > li > a").filter(function () {
    return $(this).data("selected") == true;
  }).each(function() {
    value = $(this).text();
    $("article").each(function() {
      tags = $(this).data("tags");
      if(jQuery.inArray(value, tags) > -1) {
        $(this).show();
      }
    })
  })
  

});
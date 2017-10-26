window.PopupCenter = function(url, title, w, h) {
  var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
  var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

  var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
  var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

  var left = ((width / 2) - (w / 2)) + dualScreenLeft;
  var top = ((height / 2) - (h / 2)) + dualScreenTop;

  var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

  if (window.focus) {
    newWindow.focus();
  }
}

window.set_image = function(type, url, thumbnail) {
  $("#listing_" + type + "_image").val(url);
  $("#" + type + "_image").attr("src", thumbnail).after("<br /><br />").css("zoom", "100%");
}

$("#choose_cover_photo").on("click", function() {
  window.PopupCenter("/admin/images?tag=cover", "Images", "800", "500")
  return false;
});

$("#choose_social_photo").on("click", function() {
  window.PopupCenter("/admin/images?tag=social", "Images", "800", "500")
  return false;
});

$("#upload_cover_photo").on("click", function() {
  cloudinary.openUploadWidget(
  {
    cloud_name: 'push-comedy-theater',
    upload_preset: 'upload_cover',
    sources: ["local", "url", "facebook", "dropbox", "google_photos", "instagram"],
    thumbnails: "#cover_image",
    field_name: "listing[cover_image]"
  },
  function(error, result) { console.log(error, result) });
})

$(document).on('cloudinarywidgetfileuploadsuccess', function(e, data) {
  window.set_cover_image(data.secure_url);
});

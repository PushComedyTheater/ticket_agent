import "phoenix_html"

window.log_it = function(message) {
  // Show a message on the console so devs know we're active
  if (window.console && window.console.log) {
    window.console.log(message);
  }
}
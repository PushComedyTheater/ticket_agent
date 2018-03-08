import "phoenix_html"
// import { Socket } from "phoenix";
window.console_log = function (message) {
  if (window.console && window.console.log) {
    window.console.log(message);
  }
}

window.console_group = function(message) {
  if (window.console && window.console.group) {
    window.console.group(message);
  }  
}

window.console_group_end = function () {
  if (window.console && window.console.groupEnd) {
    window.console.groupEnd();
  }
}

window.console_warn = function (message) {
  if (window.console && window.console.warn) {
    window.console.warn(message);
  }
}

window.console_error = function (message) {
  if (window.console && window.console.error) {
    window.console.error(message);
  }
}

window.console_dir = function(item) {
  if (window.console && window.console.dir) {
    window.console.dir(item);
  }
}

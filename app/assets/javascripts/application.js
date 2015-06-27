// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//
// In GOT, we want to require app (which sets up the angular app), before any controllers. This is why
// we specifically have require app before require_tree.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/dist/js/bootstrap
//= require angular
//= require angular-devise
//= require datepicker/datepicker
//= require jquery-countdown
//= require momentjs
//= require humanize-duration
//= require angular-timer
//= require app
//= require_tree .
//= require websocket_rails/main
//= require jquery.cookie
//= require jstz
//= require browser_timezone_rails/set_time_zone

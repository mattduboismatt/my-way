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
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_tree .

$(document).ready(function () {


  $(function() {
    $( "#accordion" ).accordion({
     header: "h3",
     collapsible: true,
     active: false
   });
  });


  $('#menu').hide();
  $('.hidden').hide();

  $('#logo').on('click', function(){
    $('#menu').fadeToggle();
    $('#trip').fadeToggle();
  });

  $('#show-more').on('click',function(e){
    e.preventDefault();
    $('.hidden').fadeToggle();
  });

  $('#apple-tester').on('click', function(e){
    e.preventDefault();
    var x = document.getElementById("demo");

    function showPosition(position) {
      x.innerHTML = "Latitude: " + position.coords.latitude +
      "<br>Longitude: " + position.coords.longitude;
    }

    function getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
      } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
      }
    }

    getLocation()
  })

});

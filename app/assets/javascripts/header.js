$(document).ready(function () {

  var popUp = $('#formula-pop-up')
  var siteContent = $(".site-content");

  $('#formula').on('click', function(e){
    e.preventDefault();
    popUp.show();
    popUp.animate({opacity: 1}, 400);
    siteContent.animate({opacity: 0.3}, 400);
  });

  $('#close-pop-up').on('click', function(e) {
    e.preventDefault();
    popUp.animate({opacity: 0}, 400, 'swing', function(e) { $(this).hide();});
    siteContent.animate({opacity: 1}, 400);
  });

});
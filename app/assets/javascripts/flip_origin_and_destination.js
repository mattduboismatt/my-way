$(document).ready(function () {

  $('#flip').on('click', function(e){
    e.preventDefault();

    var originFieldValue = $("#origin").val();
    var destinationFieldValue = $("#destination").val();

    $('#origin').val(destinationFieldValue);
    $('#destination').val(originFieldValue);

    if ($('#current-location').attr('title') == 'true'){
      $('#puppet-field').toggle();
      $('#origin').toggle();
      $('#destination').toggle();
      $('#tired-field').toggle();
    }

  })
});

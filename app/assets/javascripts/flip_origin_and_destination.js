$(document).ready(function () {

  $('#flip').on('click', function(e){
    e.preventDefault();

    var originFieldValue = $("#origin").val();
    var destinationFieldValue = $("#destination").val();

    $('#origin').val(destinationFieldValue);
    $('#destination').val(originFieldValue);

  })
});

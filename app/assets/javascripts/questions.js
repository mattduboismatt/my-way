$(document).ready(function () {

  $('#question-form-container').on('click', '.survey-question-form', function(e){
    e.preventDefault();
    var url = $(this).attr("action");
    var request = $.ajax({
      url: url,
      method: 'post',
      dataType: 'json',
      data: $(this).serialize() + "&content=" + escape($(e.target).val())
    });
    // debugger

    request.success(function(response){
      $('#question-form-container').html(response.question_html);
    });


  });

});

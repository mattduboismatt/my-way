$(document).ready(function () {

  var counter = $('h3 #qcount');
  var binding = $("#question-form-container");

  var redirect = function(response) {
    window.location = response.getResponseHeader('Location');
  }

  var updateQuestion = function(response) {
    window.history.pushState(null, response.question.content, response.question_path)
    counter.html(response.question.id);
    binding.html(response.question_html);
  }

  var submitAnswer = function(e) {
    e.preventDefault();
    var form = $(this).parents('form');
    var request = $.ajax({
      url: form.attr("action"),
      method: 'post',
      dataType: 'json',
      data: form.serialize() + "&content=" + escape($(e.target).val()),
      statusCode: {
        201: redirect
      }
    });

    request.success(updateQuestion);
  }

  binding.on('click', '.survey-question-form input', submitAnswer);
});

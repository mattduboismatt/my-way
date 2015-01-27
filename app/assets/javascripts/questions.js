$(document).ready(function () {

  $('.answer').on('click', function(e){
    e.preventDefault();
    // debugger
    var request = $.ajax({
      url: '/users/25/answers',
      method: 'post',
      dataType: 'json',
      data: {content: this.value}
    });
    // debugger

    request.done(function(response){
      console.log('made it')
    });
  });

});

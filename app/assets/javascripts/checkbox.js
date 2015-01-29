$(document).ready(function () {

  $('.checkdiv').on('click', function(e){
    e.preventDefault();
    var checkbox = $(this).children("input[type='checkbox']");
    checkbox.prop('checked', function(){
      return !this.checked;
    });
  });
});

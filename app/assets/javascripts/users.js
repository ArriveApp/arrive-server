document.addEventListener("page:load", function(){
  $('input[type=file]').bootstrapFileInput();

  $('#generate-pin').click(function(){
    var school_id = $(this).data().id;
    url = "/schools/"+school_id+"/pin/new";
    $.get(url, function(response) {
      $('#user_password').val(response.pin);
    });
  });
});

document.addEventListener("page:load", function () {
  $('input[type=file]').bootstrapFileInput();

  $('body').on('click', '#generate_pin', function (event) {
    var new_pin_url = $(this).data('new-pin-url'),
        password_field_id = $(this).data('password-field');

    $.get(new_pin_url)
      .success(function (response) {
        $('#' + password_field_id).val(response.pin);
      });
  });
});

$(document).on("ready page:load", function () {
  $('input[type=file]').bootstrapFileInput();
});

// Do this outside of the on ready to ensure the click is only bound to document once, using turbolinks
$(document).on('click', '#generate_pin', function (event) {
  var new_pin_url = $(this).data('new-pin-url'),
      password_field_id = $(this).data('password-field');

  $.get(new_pin_url)
    .success(function (response) {
      $('#' + password_field_id).val(response.pin);
    });
});

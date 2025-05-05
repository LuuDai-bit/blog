document.addEventListener("turbolinks:load", function() {
  const userPassword = $('#user_password');
  const userPasswordConfirmation = $('#user_password_confirmation');
  const savePasswordBtn = $('#save_password');
  let isPassed = false;

  const clearErrors = () => {
    $('.errors').toArray().forEach((error) => $(error).empty());
  };

  $(savePasswordBtn).on('click', (e) => {
    if (isPassed) return;

    e.preventDefault();

    clearErrors();
    if ($(userPassword).val() !== $(userPasswordConfirmation).val()) {
      $('#password-confirmation-error-block').append(`
        <p class="danger" id="auto_generate_message">Password confirmation does not match</p>
      `);
    } else {
      isPassed = true;
      $(e.target).trigger('click');
    }
  });

  $(userPassword).on('change', () => {
    isPassed = false;
  });

  $(userPasswordConfirmation).on('change', () => {
    isPassed = false;
  });
});

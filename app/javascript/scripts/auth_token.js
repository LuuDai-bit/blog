document.addEventListener("turbolinks:load", function() {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'auth_tokens') return;

  const peekTokenCloseBtn = $('#close-peek-token-modal');
  const authTokenPeekModal = $('#auth-token-peek');

  $(peekTokenCloseBtn).on('click', () => {
    $(authTokenPeekModal).addClass('d-none');
  })
});
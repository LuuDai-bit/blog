document.addEventListener("turbolinks:load", function() {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'announcements') return;

  const activateAnnouncementBtn = $('.activate-announcement');
  const selectAnnouncementDurationModal = $('#announcement-duration');
  const closeAnnouncementDurationModalBtn = $('#close-announcement-duration-modal');
  const cancelAnnouncementDurationModalBtn = $('#cancel-announcement-duration-modal');
  const activateAnnouncementModalBtn = $('#activate-announcement-btn');
  let updateAnnouncementId = 1;

  $(activateAnnouncementBtn).on('click', (e) => {
    e.preventDefault();

    selectAnnouncementDurationModal.removeClass('d-none');
    updateAnnouncementId = $(e.target).data('id');
  });

  $(closeAnnouncementDurationModalBtn).on('click', () => {
    if (selectAnnouncementDurationModal.hasClass('d-none')) return;

    selectAnnouncementDurationModal.addClass('d-none');
  });

  $(cancelAnnouncementDurationModalBtn).on('click', () => {
    if (selectAnnouncementDurationModal.hasClass('d-none')) return;

    selectAnnouncementDurationModal.addClass('d-none');
  });

  $('.announcement-duration-option').on('click', (e) => {
    $('.announcement-duration-option>div').removeClass('selected')
    $(e.target).addClass('selected')
  })

  $(activateAnnouncementModalBtn).on('click', (e) => {
    const selectedAnnouncementOption = $('.announcement-duration-option>.selected')[0];
    const durationSecond = $(selectedAnnouncementOption).data('duration-second');
    let url = $('#update-announcement-path').val();
    url = url.slice(0, -1) + updateAnnouncementId;

    $.ajax({
      type: 'PATCH',
      url: url,
      data: {
        announcement: {
          duration: durationSecond,
          activated: true
        }
      }
    });

    $(selectAnnouncementDurationModal).addClass('d-none');
  })
});

$(document).ready(function() {
  $('.sidebar-collapse-btn').click(function() {
    const targetId = $(this).attr('data-bs-target');
    const targetGroup = $(targetId);
    const icon = $(this).find('.collapse-icon');

    if (targetGroup.hasClass('show')) {
      targetGroup.removeClass('show');
      icon.text('▼');
    } else {
      targetGroup.addClass('show');
      icon.text('▲');
    }
  });
});

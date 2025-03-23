document.addEventListener("turbolinks:load", function() {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'posts') return;

  const autosave = $('#auto_save')[0];
  if (!autosave) return;

  const DefaultIntervalTime = 10000;

  const saving = $('#saving');
  const postId = $($('#post_id')[0]).val();

  // Handle call update ajax to save post
  const savePost = () => {
    if (!$('#auto_save')[0]) {
      console.log(autosaveInterval);
      clearInterval(autosaveInterval);
      return;
    }

    if (!$(autosave).is(':checked')) return;

    $(saving).show();

    const post = {
      subject: $('#post_subject').val(),
      subject_en: $('#post_subject_en').val(),
      content: $('#post_content').val(),
      content_en: $('#post_content_en').val(),
      status: $($('#post_status_publish')[0]).is(':checked') ? 'publish' : 'draft'
    }

    $.ajax({
      method: 'PATCH',
      // accepts: 'application/json',
      url: "/admin/posts/" + postId,
      data: { post: post },
      dataType: 'json',

      cache: false,
      success: () => {
        $(saving).hide();
      }
    })
  };

  let autosaveInterval = setInterval(savePost, DefaultIntervalTime);

  // Handle turn on and off interval
  $(autosave).change(() => {
    if ($(autosave).is(':checked')) {
      autosaveInterval = setInterval(savePost, DefaultIntervalTime);
    } else {
      $(saving).hide();
      clearInterval(autosaveInterval);
    }
  });
});

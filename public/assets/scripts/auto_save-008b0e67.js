document.addEventListener("DOMContentLoaded", function () {
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
      post_id: postId,
    }

    const url = $('#draft_post_url').val()
    const draftPostId = $('#draft_post_id').val();
    let method = 'POST'
    if (draftPostId) {
      url = `${url}/${draftPostId}`;
      method = 'PATCH';
    }

    $.ajax({
      method: method,
      // accepts: 'application/json',
      url: url,
      data: { draft_post: post },
      dataType: 'json',
      cache: false,
      success: (data) => {
        $(saving).hide();
        const newDraftPostId = data['draft_post_id'];
        if (newDraftPostId) $('#draft_post_id').val(newDraftPostId);
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

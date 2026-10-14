document.addEventListener("DOMContentLoaded", function () {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'posts') return;

  const autosave = $('#auto_save')[0];
  if (!autosave) return;

  const DefaultIntervalTime = 10000;

  const saving = $('#saving');
  const postId = $($('#post_id')[0]).val();
  const draftPostId = $('#draft_post_id').val();

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
    }

    let url = $('#draft_post_url').val()
    let method = 'POST'
    if (draftPostId) {
      url = `${url}/${draftPostId}`;
      method = 'PATCH';
    }

    $.ajax({
      method: method,
      // accepts: 'application/json',
      url: url,
      data: { draft_post: post, original_post_id: postId },
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

document.addEventListener('DOMContentLoaded', () => {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'feeds') return;

  const sentinel = document.querySelector('#see_more_meta');

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting && sentinel.dataset.loading !== "true") {
        sentinel.dataset.loading = "true";

        if($('#see_more_link')[0]) $('#see_more_link')[0].click();

        setTimeout('', 5000);

        sentinel.dataset.loading = "false";
      }
    });
  }, { threshold: 0.1 });

  observer.observe(sentinel);

  $('.feed_link_btn').on('click', (e) => {
    let markAsReadBtn = $(e.target).siblings('.mark_as_read_btn');
    let id = $(e.target).data("id");
    let url = $(markAsReadBtn).attr('href');
    $.ajax({
      type: 'PATCH',
      url: url,
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      data: {
        id: id,
      },
      dataType: 'json',
    }).done(() => {
      $(`#feed-${id}`).removeClass('d-none');
    }).fail(() => {
      console.log("Mark as read failed");
    });
  });
});
document.addEventListener("turbolinks:load", function() {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'posts') return;

  let categories = [];

  $('.category-preview').toArray().forEach((category) => {
    categories.push($(category).html());
  });

  $('#post_categories').val(categories.join(';'));

  const displayError = (message) => {
    if (!message) return;

    $('#error-message-categories').removeClass('d-none');
    $('#error-message-categories').html(message);
  };

  const validCategory = (name) => {
    if (!name) {
      displayError('Category can not be blank');
      return false;
    } else if (name.length > 20) {
      displayError('Category has more than 20 characters');
      return false;
    } else if (categories.indexOf(name) !== -1) {
      displayError('Duplicate category');
      return false;
    } else if (categories.length >= 5) {
      displayError('Can only add upto 5 categories');
      return false;
    }

    return true;
  };

  const displayCategories = () => {
    let html = '';
    categories.forEach((c) => {
      html += `
        <div class="position-relative category-preview-wrapper">
          <span class="category-preview truncate">${c}</span>
          <div class="delete-category-btn">X</div>
        </div>
      `;
    });
    $('#categories-preview').html(html);
  };

  $('#add-category-btn').on('click', (e) => {
    e.preventDefault();

    const category = $('#post_category').val();
    if (validCategory(category)) {
      categories.push(category);
      $('#post_categories').val(categories.join(';'));
      $('#post_category').val('');
      displayCategories();
    }
  });
})

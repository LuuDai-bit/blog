document.addEventListener("turbolinks:load", function() {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'posts') return;

  let categories = [];

  // Import exist category to categories array
  $('.category-preview').toArray().forEach((category) => {
    categories.push($(category).html().trim());
  });

  // Update value of post_categories param by the current categories
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

  // handle category delete button click event
  const handleDeleteBtn = () => {
    $('.delete-category-btn').on('click', (e) => {
      // Get the category element
      const categoryElem = $(e.target).siblings('.category-preview');
      const name = $(categoryElem).html().trim();
      // Remove the selected category from the categories array
      const index = categories.indexOf(name);
      if (index > -1) categories.splice(index, 1);
      // Update categories input params
      $('#post_categories').val(categories.join(';'));
      // Rerender categories block
      displayCategories();
    });
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
    handleDeleteBtn();
  };

  // Handle add category button
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

  // Handle delete category button event when first load page
  handleDeleteBtn();
})

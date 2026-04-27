document.addEventListener('DOMContentLoaded', () => {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'categories') return;

  const checkbox = document.getElementById('category_highlighted');
  const orderInput = document.getElementById('category_highlight_order');

  if (checkbox && orderInput) {
    const toggleOrderInput = () => {
      orderInput.disabled = !checkbox.checked;
    };

    checkbox.addEventListener('change', toggleOrderInput);
    toggleOrderInput();
  }
});

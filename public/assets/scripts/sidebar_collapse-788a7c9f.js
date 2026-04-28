document.addEventListener('DOMContentLoaded', function() {
  const collapseButtons = document.querySelectorAll('.sidebar-collapse-btn');

  collapseButtons.forEach(button => {
    button.addEventListener('click', function() {
      console.log("test")
      const targetId = this.getAttribute('data-target');
      const targetGroup = document.getElementById(targetId);
      const icon = this.querySelector('.collapse-icon');

      if (targetGroup.classList.contains('show')) {
        targetGroup.classList.remove('show');
        icon.textContent = '▼';
      } else {
        targetGroup.classList.add('show');
        icon.textContent = '▲';
      }
    });
  });
});

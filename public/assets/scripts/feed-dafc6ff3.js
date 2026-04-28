document.addEventListener('DOMContentLoaded', () => {
  const pathName = window.location.pathname.split("/")[2];
  if (pathName != 'feeds') return;

  const sentinel = document.querySelector('#see_more_meta');
  console.log(sentinel);

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      // If the div is visible and we aren't already loading
      if (entry.isIntersecting && sentinel.dataset.loading !== "true") {
        sentinel.dataset.loading = "true";
console.log("Doing it")
        $('#see_more_link').trigger("click");

        setTimeout('', 5000);

        sentinel.dataset.loading = "false";
      }
    });
  }, { threshold: 0.1 });

  observer.observe(sentinel);
});
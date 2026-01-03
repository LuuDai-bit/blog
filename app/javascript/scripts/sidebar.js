document.addEventListener('turbolinks:load', () => {
  console.log('Sidebar script initializing')
  const toggle = $('#sidebarToggle')
  const sidebar = $('.sidebar')
console.log('Sidebar elements:', $(toggle), $(sidebar))
  if (!$(toggle) || !$(sidebar)) return
console.log('Sidebar script loaded')
  $(toggle).addEventListener('click', (e) => {
    console.log('Toggling sidebar')
    $(sidebar).css('display', 'block')
    $(toggle).css('display', 'none')
  })

  // Close sidebar when clicking outside on mobile
  document.addEventListener('click', (e) => {
    if (!sidebar.classList.contains('open')) return
    if (e.target === toggle || sidebar.contains(e.target)) return
    sidebar.classList.remove('open')
  })
})

document.addEventListener('turbolinks:load', () => {
  const toggle = $('#sidebarToggle')[0]
  const sidebar = $('.sidebar')[0]
  const closeBtn = $('#sidebarClose')[0]

  if (!$(toggle) || !$(sidebar)) return

  $(toggle).on('click', (e) => {
    e.preventDefault()

    $(sidebar).css('display', 'block')
    $(toggle).addClass('d-none')
    $(closeBtn).removeClass('d-none')
  })

  // Close sidebar when clicking outside on mobile
  $(closeBtn).on('click', (e) => {
    e.preventDefault()

    $(sidebar).css('display', 'none')
    $(toggle).removeClass('d-none')
    $(closeBtn).addClass('d-none')
  })
})

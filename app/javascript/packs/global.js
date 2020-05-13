$(document).ready(() => {
  setTimeout(() => {
    $('.flash-container').fadeOut(2000)
  }, 2000)
})


$('#menu-popper').click(() => {
  $('#main').toggleClass('main-phased')
})


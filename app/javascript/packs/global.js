$(document).ready(() => {
  setTimeout(() => {
    $('.flash-container').fadeOut(1000)
  }, 1000)
})


$('#menu-popper').click(() => {
  $('#main').toggleClass('main-phased')
  $('#new-item-link').toggleClass('nitem-link-phased')
  $('#menu-bar1').toggleClass('changed-top')
  $('#menu-bar3').toggleClass('changed-bot')
  $('#items-list').toggleClass('items-list-phased')
})


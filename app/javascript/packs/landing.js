/* document.getElementById('flash-container').addEventListener('click', (e) => {
  e.target.style.visibility = 'hidden'
}) */

$(document).ready(() => {
  setTimeout(() => {
    $('#flash-container').fadeOut(2000)
  }, 2000);
})
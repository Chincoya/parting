$('#task_name').change((event) => {
  console.log(event.target.value)
  if (event.target.value.length < 10 ) {
    $('#task_name').addClass('form-error')
  }else {
    $('#task_name').removeClass('form-error')
  }

})
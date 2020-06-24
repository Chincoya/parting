
const selected = {}

const addSelection = (name) => {
  nameForHTML = name.replace(' ', '-')
  selection = document.createElement('span')
  selection.innerText = `${name} X`
  selection.id = `selected-${nameForHTML}`
  selection.classList.add('selected-option')
  selection.addEventListener('click', (e) => {
    e.target.parentNode.removeChild(e.target)
    tag = e.target.innerText.slice(0, -2)
    delete selected[tag]
    $('#selection-holder').val(JSON.stringify(selected))
  })

  return selection
}

$('#group-select').change((e) => {
  if(e.target.value != 'None'){
    selected[e.target.value] = 1
    $('#selector-displayer').append(addSelection(e.target.value))
    $('#selection-holder').val(JSON.stringify(selected))
  }
})
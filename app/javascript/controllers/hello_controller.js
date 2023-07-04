import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
console.log('Hello!')

window.addEventListener( 'scroll' , () =>
{
  const w = parseInt( ( window.pageYOffset / ( document.body.offsetHeight - window.innerHeight ) ) * 100 )
  // const w = parseInt( ( window.pageYOffset / window.innerHeight ) * 100 )
  document.getElementById('offset').textContent = `${window.pageYOffset}`
  document.getElementById('height').textContent = `${document.body.offsetHeight}`
  document.getElementById('inner').textContent = `${window.innerHeight}`

  document.getElementById('percent').textContent = `${w}%`
})

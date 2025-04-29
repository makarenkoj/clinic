import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  static values = { url: String }

  connect() {
    if (!navigator.share) {
      this.element.hidden = true
    }
  }

  click() {
    navigator.share({url: this.urlValue})
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Initialize the dropdown as hidden
    this.hide()
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  hide(event) {
    // Don't hide if clicking inside the dropdown
    if (this.element.contains(event?.target)) {
      return
    }
    this.menuTarget.classList.add("hidden")
  }
}

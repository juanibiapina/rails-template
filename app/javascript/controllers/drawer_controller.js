import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "overlay", "closeButton"]

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this)
    this.handleTransitionEnd = this.handleTransitionEnd.bind(this)
    this.handleDrawerOpen = this.handleDrawerOpen.bind(this)
    // Always hide panel and overlay on connect
    this.panelTarget.classList.add("hidden", "-translate-x-full")
    this.panelTarget.classList.remove("translate-x-0")
    this.overlayTarget.classList.add("hidden")
    window.addEventListener("drawer:open", this.handleDrawerOpen)
  }

  disconnect() {
    window.removeEventListener("drawer:open", this.handleDrawerOpen)
  }

  handleDrawerOpen() {
    this.open()
  }

  open() {
    this.panelTarget.classList.remove("hidden")
    this.panelTarget.offsetHeight // force reflow for transition
    this.panelTarget.classList.remove("-translate-x-full")
    this.panelTarget.classList.add("translate-x-0")
    this.overlayTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
    document.addEventListener("keydown", this.handleKeydown)
  }

  close() {
    this.panelTarget.classList.add("-translate-x-full")
    this.panelTarget.classList.remove("translate-x-0")
    this.panelTarget.addEventListener("transitionend", this.handleTransitionEnd, { once: true })
    this.overlayTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
    document.removeEventListener("keydown", this.handleKeydown)
  }

  handleTransitionEnd() {
    this.panelTarget.classList.add("hidden")
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  overlayClick(event) {
    if (event.target === this.overlayTarget) {
      this.close()
    }
  }
}

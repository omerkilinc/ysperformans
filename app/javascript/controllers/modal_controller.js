import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  disconnect() {
    this.modal.hide()
    this.element.remove()
  }

  hideBeforeRender(event) {
    if (this.isOpen()) {
      event.preventDefault()
      this.element.addEventListener('hidden.bs.modal', event.detail.resume())
      this.modal.hide()
      this.element.remove()
    }
  }

  submitEnd(e){
    if(e.detail.success)
      this.modal.hide()
  }

  get modalTurboFrame() {
    return document.querySelector("turbo-frame[id='modal1']")
  }

  isOpen() {
    return this.element.classList.contains("show")
  }

  clear(){
    this.element.innerHTML = null
  }

}

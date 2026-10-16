import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body"]

  hide() {
    this.bodyTarget.hide()
  }
}

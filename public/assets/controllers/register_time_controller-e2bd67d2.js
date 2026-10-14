import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.value = (new Date().getTimezoneOffset()) / 60 * (-1);
  }
}

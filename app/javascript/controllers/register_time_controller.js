import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log((new Date().getTimezoneOffset()) / 60);
    this.element.value = (new Date().getTimezoneOffset()) / 60;
  }
}

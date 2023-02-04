import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('test');
    this.element.value = (new Date().getTimezoneOffset()) / 60;
  }
}

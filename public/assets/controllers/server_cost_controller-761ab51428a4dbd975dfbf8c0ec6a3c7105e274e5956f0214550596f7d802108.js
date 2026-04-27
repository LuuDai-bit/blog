import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["serverCost", "scUrl"];

  connect() {
    const path = this.scUrlTarget.value;
    const getServerCost = async () => {
      const response = await fetch(path, {
        method: 'GET'
      })

      const responseJson = await response.json();
      if (response.ok) {
        this.serverCostTarget.innerHTML = responseJson.server_cost;
      }
    }

    getServerCost()
  }
};

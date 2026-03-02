import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "container", "repositoriesSelect"];

  open() {
    this.containerTarget.classList.remove('d-none');
  }

  close() {
    this.containerTarget.classList.add('d-none');
  }

  submit(event) {
    event.preventDefault();
    const formData = new FormData(this.formTarget);
    const obj = Object.fromEntries(formData.entries());
    const path = this.formTarget.action;

    const saveRepository = async () => {
      const response = await fetch(path, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify(obj)
      });

      if (response.ok) {
        const newOption = document.createElement('option');
        const responseJson = await response.json();
        const data = responseJson.data;
        newOption.value = data.id;
        newOption.text = data.full_name;
        this.repositoriesSelectTarget.appendChild(newOption);
        this.close();
      }
    }

    saveRepository();
  }
}

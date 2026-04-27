import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "container", "repositoriesSelect", "error"];

  open() {
    this.containerTarget.classList.remove('d-none');
  }

  close() {
    this.containerTarget.classList.add('d-none');
    this.formTarget.reset();
    this.errorTarget.classList.add('d-none');
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

      const responseJson = await response.json();

      if (response.ok) {
        const newOption = document.createElement('option');
        const data = responseJson.data;
        newOption.value = data.id;
        newOption.text = data.full_name;
        newOption.selected = true;
        this.repositoriesSelectTarget.appendChild(newOption);
        this.formTarget.reset();
        this.errorTarget.classList.add('d-none');

        this.repositoriesSelectTarget.dispatchEvent(new Event('change'));

        this.close();
      } else {
        const data = responseJson.error;
        this.errorTarget.textContent = data.errors.join(', ');
        this.errorTarget.classList.remove('d-none');
      }
    }

    saveRepository();
  }
};

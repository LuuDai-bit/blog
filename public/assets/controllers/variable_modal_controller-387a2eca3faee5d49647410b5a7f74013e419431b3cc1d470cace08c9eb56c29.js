import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "error", "container", "variablePath",
    "nameInput", "formatInput", "tableBody", "variableTypeString",
    "variableTypeBoolean", "bsmInput", "bfmInput",
    "bsmInputContainer", "bfmInputContainer"];

  connect() {
    this.variableId = null;
    const path = window.location.pathname
    const segments = path.split("/")
    const index = segments.indexOf("repository_configs")
    this.repositoryId = segments[index + 1]
  }

  open(event) {
    event.preventDefault();
    this.variableId = event.target.dataset.variableId;
    if (this.variableId) {
      this.nameInputTarget.value = event.target.dataset.variableName;
      this.formatInputTarget.value = event.target.dataset.variableFormat;
      if (event.target.dataset.variableType === "string") {
        this.variableTypeStringTarget.checked = true;
      } else {
        this.variableTypeBooleanTarget.checked = true;
        this.changeVariableType(event);
      }
      this.bsmInputTarget.value = event.target.dataset.bsmInput;
      this.bfmInputTarget.value = event.target.dataset.bfmInput;
    }
    this.containerTarget.classList.remove('d-none');
  }

  close() {
    this.containerTarget.classList.add('d-none');
    this.formTarget.reset();
    this.errorTarget.classList.add('d-none');
    this.bsmInputContainerTarget.classList.add('d-none');
    this.bfmInputContainerTarget.classList.add('d-none');
  }

  changeVariableType(event) {
    event.preventDefault();
    if (event.target.value === "string") {
      this.bsmInputContainerTarget.classList.add('d-none');
      this.bfmInputContainerTarget.classList.add('d-none');
      this.bsmInputTarget.value = "";
      this.bfmInputTarget.value = "";
    } else {
      this.bsmInputContainerTarget.classList.remove('d-none');
      this.bfmInputContainerTarget.classList.remove('d-none');
    }
  }

  submit(event) {
    event.preventDefault();
    const formData = new FormData(this.formTarget);
    const obj = Object.fromEntries(formData.entries());
    obj.repository_id = this.repositoryId;
    obj.id = this.variableId;
    const path = this.variableId ? `${this.variablePathTarget.value}/${this.variableId}` : this.variablePathTarget.value;

    const saveVariable = async () => {
      const method = this.variableId ? 'PATCH' : 'POST';
      const response = await fetch(path, {
        method: method,
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify(obj)
      });

      const responseJson = await response.json();

      if (response.ok) {
        const html = responseJson.data;
        this.tableBodyTarget.innerHTML = html;
        this.close();
      } else {
        const data = responseJson.error;
        this.errorTarget.textContent = data.errors.join(', ');
        this.errorTarget.classList.remove('d-none');
      }
    }

    saveVariable();
  }

  delete(event) {
    event.preventDefault();
    this.variableId = event.target.dataset.variableId;
    const path = `${this.variablePathTarget.value}/${this.variableId}?repository_id=${this.repositoryId}`;

    const deleteVariable = async () => {
      const response = await fetch(path, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      });

      const responseJson = await response.json();

      if (response.ok) {
        const html = responseJson.data;
        this.tableBodyTarget.innerHTML = html;
      }
    }

    deleteVariable();
  }
};

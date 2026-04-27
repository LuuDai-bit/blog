import { Controller } from "@hotwired/stimulus"
import "commonmark"

export default class extends Controller {
  static targets = ["source", "preview", "variablesPath", "variables", "repositoriesSelect"]

  connect() {
    this.generatePreview();
  }

  generatePreview() {
    const inputValue = this.sourceTarget.value;
    const reader = new window.commonmark.Parser();
    const writer = new window.commonmark.HtmlRenderer();
    const parsed = reader.parse(inputValue);
    const html = writer.render(parsed);
    this.previewTarget.innerHTML = html;
  }

  reloadVariables() {
    const variablesPath = this.variablesPathTarget.value;
    const repositoryId = this.repositoriesSelectTarget.value;
    const fetchVariables = async () => {
      const response = await fetch(`${variablesPath}?repository_id=${repositoryId}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      })
      const data = await response.json();
      this.variablesTarget.innerHTML = data.data;
    };

    fetchVariables();
  }

};

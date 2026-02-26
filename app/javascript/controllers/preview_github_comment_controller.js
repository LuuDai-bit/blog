import { Controller } from "@hotwired/stimulus"
import { Parser, HtmlRenderer } from "commonmark";

export default class extends Controller {
  static targets = [ "source", "preview" ]

  connect() {
    const inputValue = this.sourceTarget.value;
    const reader   = new Parser();
    const writer   = new HtmlRenderer();
    const parsed   = reader.parse(inputValue);
    const html     = writer.render(parsed);
    this.previewTarget.innerHTML = html;
  }

  generatePreview() {
    const inputValue = this.sourceTarget.value;
    const reader   = new Parser();
    const writer   = new HtmlRenderer();
    const parsed   = reader.parse(inputValue);
    const html     = writer.render(parsed);
    this.previewTarget.innerHTML = html;
  }
}

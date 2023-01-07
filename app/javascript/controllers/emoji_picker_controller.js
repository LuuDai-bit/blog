import { Controller } from "@hotwired/stimulus";
import { createPopup } from "@picmo/popup-picker";
import { RichText } from "../classes/RichText";

export default class extends Controller {
  static targets = ["trixEditor", "pickerContainer"];

  connect() {
    const buttonString = this.emojiButtonString();
    const emojiButton = this.emojiButtonTemplate(buttonString);
    let picker;
    let richText = new RichText(picker, emojiButton) // Tai sao ko new no o duoi do phai set lai picker

    picker = createPopup({
      rootElement: this.pickerContainerTarget
    }, {
      triggerElement: emojiButton,
      referenceElement: emojiButton,
      position: "bottom-start",
    });

    picker.addEventListener("emoji:select", (event) => {
      this.trixEditorTarget.editor.insertString(event.emoji)
    })

    richText.setPicker(picker);
  }

  emojiButtonTemplate(buttonString) {
    const domParser = new DOMParser();
    const emojiButton = domParser
      .parseFromString(buttonString, "text/html")
      .querySelector("button");

    return emojiButton;
  }

  emojiButtonString() {
    const buttonString = `<button class="trix-button" id="emoji-picker" data-trix-action="popupPicker" tab-index="1">Emoji</button>`;

    return buttonString;
  }
}

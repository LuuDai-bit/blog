import { Controller } from "@hotwired/stimulus";
import { createPopup } from "@picmo/popup-picker";
import { RichText } from "../classes/RichText";

export default class extends Controller {
  static targets = ["trixEditor", "trixEditorEn", "pickerContainer", "pickerContainerEn"];

  connect() {
    this.appendEmojiPicker(this.pickerContainerTarget, this.trixEditorTarget, 0)

    this.appendEmojiPicker(this.pickerContainerEnTarget, this.trixEditorEnTarget, 1)
  }

  appendEmojiPicker(pickerContainerTarget, trixEditorTarget, position) {
    let buttonString = this.emojiButtonString();
    let emojiButton = this.emojiButtonTemplate(buttonString);
    let picker;
    let richText = new RichText(picker, emojiButton, position)

    picker = createPopup({
      rootElement: pickerContainerTarget
    }, {
      triggerElement: emojiButton,
      referenceElement: emojiButton,
      position: "bottom-start",
    });

    picker.addEventListener("emoji:select", (event) => {
      trixEditorTarget.editor.insertString(event.emoji)
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

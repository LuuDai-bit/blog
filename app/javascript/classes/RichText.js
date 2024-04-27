export class RichText {
  constructor(picker, emojiButton, position=0) {
    this.picker = picker
    this.emojiButton = emojiButton
    this.position = position
    this.createEmojiPickerButton();
  }

  createEmojiPickerButton() {
    this.emojiButton.addEventListener('click', this.toggleEmojiPicker.bind(this));
    document
      .querySelectorAll("[data-trix-button-group=block-tools]")[this.position]
      .prepend(this.emojiButton);
  }

  toggleEmojiPicker(event) {
    this.picker.toggle();
  }

  setPicker(picker) {
    this.picker = picker;
  }
}

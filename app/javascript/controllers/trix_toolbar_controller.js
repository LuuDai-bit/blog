import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const trixToolbars = document.querySelectorAll('[id^=trix-toolbar]');
    const trixEditors = document.querySelectorAll('[id^=trix-content-editor]');
    const trixEditorVn = trixEditors[0]
    const trixEditorEn = trixEditors[1]
    const adminContainer = document.getElementsByClassName('admin-container')[0];

    trixEditorVn.onscroll = function() {stickyScroll(trixEditorVn, trixToolbars[0])}
    trixEditorEn.onscroll = function() {stickyScroll(trixEditorEn, trixToolbars[1])}
    adminContainer.onscroll = function() {stickyScroll()}

    function stickyScroll(trixEditor, trixToolbar) {
      var distanceToolbarToTop = trixToolbar.offsetTop;
      var distanceEditorToTop = trixEditor.offsetTop;
      var sticky = distanceToolbarToTop - distanceEditorToTop;
      var scrolled = adminContainer.scrollTop === 0 ? 0 : adminContainer.scrollTop + window.scrollY;
      var contentLabelToTop = document.getElementById('content-label').offsetTop - scrolled;

      if(trixEditor.scrollTop > sticky){
        trixToolbar.classList.add('sticky');
        trixToolbar.style.top = `${contentLabelToTop}px`;
      }
      if (trixEditor.scrollTop == 0) {
        trixToolbar.classList.remove('sticky');
        trixToolbar.style = '';
      }
    }
  }
}

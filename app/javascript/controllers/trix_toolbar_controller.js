import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const trixToolbar = document.querySelectorAll('[id^=trix-toolbar]')[0];
    const trixEditor = document.getElementById('trix-content-editor');
    const adminContainer = document.getElementsByClassName('admin-container')[0];

    trixEditor.onscroll = function() {stickyScroll()}
    adminContainer.onscroll = function() {stickyScroll()}

    function stickyScroll() {
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

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const trixToolbar = document.querySelectorAll('[id^=trix-toolbar]')[0];

    const trixEditor = document.getElementById('trix-content-editor');
    trixEditor.onscroll = function() {stickyScroll()};

    var distanceToolbarToTop = trixToolbar.offsetTop;
    var distanceEditorToTop = trixEditor.offsetTop;
    var sticky = distanceEditorToTop - distanceToolbarToTop;

    var contentLabelToTop = document.getElementById('content-label').offsetTop;

    function stickyScroll() {
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

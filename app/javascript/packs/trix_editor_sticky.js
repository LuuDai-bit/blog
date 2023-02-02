$(document).ready(function () {
  var trix_toolbar = document.getElementById('trix-toolbar-1');

  if(trix_toolbar) {
    console.log('haha');
    trix_editor = document.getElementById('trix-content-editor');
    trix_editor.onscroll = function() {stickyScroll()};

    var distanceToolbarToTop = trix_toolbar.offsetTop;
    var distanceEditorToTop = trix_editor.offsetTop;
    var sticky = distanceEditorToTop - distanceToolbarToTop;

    var content_label_to_top = document.getElementById('content-label').offsetTop;

    function stickyScroll() {
      if(trix_editor.scrollTop > sticky){
        trix_toolbar.classList.add('sticky');
        trix_toolbar.style.top = `${content_label_to_top}px`;
      }
      if (trix_editor.scrollTop == 0) {
        trix_toolbar.classList.remove('sticky');
        trix_toolbar.style = '';
      }
    }
  }
});

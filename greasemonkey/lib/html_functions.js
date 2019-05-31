function clearPage(container, stepButtonsLabel) {
  $('body').empty();

  if (null != stepButtonsLabel) {
    for (var i=1; i<4; i++) {
      $("<button id='startPoint"+i+"'>"+i+" шага до "+stepButtonsLabel+"</button>").insertBefore($(container).children().first());
    }
  }
}
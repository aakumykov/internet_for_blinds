function clearPage(stepButtonsLabel) {
  $('body').empty();

  if (null != stepButtonsLabel) {
	  $('body').append("<button id='startPoint4'>4 шага до "+stepButtonsLabel+"</button>");
	  $('body').append("<button id='startPoint3'>3 шага до "+stepButtonsLabel+"</button>");
	  $('body').append("<button id='startPoint2'>2 шага до "+stepButtonsLabel+"</button>");
	  $('body').append("<button id='startPoint1'>1 шаг до "+stepButtonsLabel+"</button>");
  }
}
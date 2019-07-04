
function clearPage(stepButtonsLabel) {
	clearHTML()
	clearCSS()
	createStepButtons(stepButtonsLabel)
}

function clearHTML() {
  $('body').empty();
}

function clearCSS() {
    for (let i=0; i<document.styleSheets.length; i++) {
        document.styleSheets[i].disabled = true;
    }
}

function createStepButtons(stepButtonsLabel) {
	if (null != stepButtonsLabel) {
		$('body').append("<button id='startPoint4'>4 шага до "+stepButtonsLabel+"</button>");
		$('body').append("<button id='startPoint3'>3 шага до "+stepButtonsLabel+"</button>");
		$('body').append("<button id='startPoint2'>2 шага до "+stepButtonsLabel+"</button>");
		$('body').append("<button id='startPoint1'>1 шаг до "+stepButtonsLabel+"</button>");
		$('body').append("<br>");
	}
}

function clearPage2(titleText, stepButtonsLabel) {
	clearHTML2()
	clearCSS2()
	
	if (null != titleText)
		createStepButtons2(stepButtonsLabel)
	
	if (null != stepButtonsLabel)
		createTitleButton2(titleText)
}

function clearHTML2() {
  $('body').empty();
}

function clearCSS2() {
    for (let i=0; i<document.styleSheets.length; i++) {
        document.styleSheets[i].disabled = true;
    }
}

function createTitleButton2(titleText) {
    let documentCorpus = $('body');
    if (null == titleText) titleText = "*";
    documentCorpus.append("<br><button id='startPoint'>*</button><br><br>");
    documentCorpus.append("<br><button id='startPoint'>"+titleText+"</button><br><br>");
}

function createStepButtons2(stepButtonsLabel) {
	$('body').append("<button id='startPoint4'>4 шага до "+stepButtonsLabel+"</button>");
	$('body').append("<button id='startPoint3'>3 шага до "+stepButtonsLabel+"</button>");
	$('body').append("<button id='startPoint2'>2 шага до "+stepButtonsLabel+"</button>");
	$('body').append("<button id='startPoint1'>1 шаг до "+stepButtonsLabel+"</button>");
	$('body').append("<br>");
}
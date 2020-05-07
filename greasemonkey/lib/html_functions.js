function clearPage(stepButtonsLabel) {
  $('body').empty();

  if (null != stepButtonsLabel) {
	  $('body').append("<button id='startPoint4'>4 шага до "+stepButtonsLabel+"</button>");
	  $('body').append("<button id='startPoint3'>3 шага до "+stepButtonsLabel+"</button>");
	  $('body').append("<button id='startPoint2'>2 шага до "+stepButtonsLabel+"</button>");
	  $('body').append("<button id='startPoint1'>1 шаг до "+stepButtonsLabel+"</button>");
  }
}


function clearPage(stepButtonsLabel, buttonsCount) {
	$('body').empty();

	if (null != stepButtonsLabel) 
	{
		for (let i=buttonsCount; i>0; i--) 
		{
			let id="startPoint"+i;
			let text = i+" шага";
			$('body').append("<button id='"+id+"'>"+text+" до "+stepButtonsLabel+"</button>");
		}
	}
}

/*function pluralizeStepWord(number) {
	let numString=String(n);
	let latNum = numString.charAt(numString.length - 1);

	switch (latNum) {
		case 0:
			return "шагов";
		case 1:
			return "шаг";
		case 2:
		case 3:
		case 4:
			return "шага";
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
			return "шагов";
	}
}*/


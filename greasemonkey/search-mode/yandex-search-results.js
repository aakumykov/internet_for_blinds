// ==UserScript==
// @name     Яндекс (результаты поиска)
// @version  1
// @grant    none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require      https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// @require      https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/html_functions.js
// @include  https://yandex.ru/search/*
// ==/UserScript==

var $ = window.jQuery;

function insertSearchIcon() {
  let imageData = "data:image/png;base64,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";
  let image = $("<img style='position:fixed; top:3px; left:3px; '/>");
	image.attr("src", imageData);  
  $(document.body).append(image);
}

$(document).ready(function(e){
  
  // Оповещаю об завершении поиска
  playAudio('http://127.0.0.1/search-complete.mp3');
  
  
  // Элемент на странице, к которому будет прикреплён программно созданный список
  var topContainer = document.querySelector('.content__left');
  
  
  // HTML-элемент контейнер наших результатов
  var newResultsContainer = document.createElement('UL');
    newResultsContainer.id = 'newResultsContainer';
    newResultsContainer.style.listStyleType = 'none';
    newResultsContainer.style.borderStyle = 'dashed';
    newResultsContainer.style.borderWidth = 4;
    newResultsContainer.style.borderColor = 'limegreen';
  	newResultsContainer.style.marginLeft = '70px';
    newResultsContainer.style.width = '100%';
    newResultsContainer.style.lineHeight = '2em';
    newResultsContainer.style.fontSize = '200%';
  
  
  // Собираю ссылки со страницы
  var linkItems = document.querySelectorAll('A.organic__url');
  //alert("linkItems.length="+linkItems.length);
  
  
  // Обрабатываю ссылки
  for (var i=0; i<linkItems.length; i++) {
    var item = linkItems[i];
    
    var linkText = item.innerText;
    var linkAddress = item.href;
    //alert(linkText+"\n"+linkAddress);
    
    var resultLine = document.createElement('LI');
    
    var resultAnchor = document.createElement('A');
        resultAnchor.href = linkAddress;
        resultAnchor.innerText = linkText;
        resultAnchor.target = '_blank';
    
    resultLine.appendChild(resultAnchor);
    
    newResultsContainer.appendChild(resultLine);
  }
  
  
  // Очищаю страницу
  //var element = document.createElement("link");
  //element.setAttribute("rel", "stylesheet");
  //element.setAttribute("type", "text/css");
  //element.setAttribute("href", "external.css");
  //document.getElementsByTagName("head")[0].appendChild(element);
  clearPage(newResultsContainer, "результатов поиска");
  
  document.body.style="";
  document.body.setAttribute("class","");
  document.body.setAttribute("style","");
  document.body.setAttribute("data-bem","");
  document.body.setAttribute("data-log-node","");
  
  insertSearchIcon();
  
  // Прикрепляю воссозданный список результатов
  document.body.appendChild(newResultsContainer);
  
});



// ==UserScript==
// @name     Яндекс (результаты поиска)
// @version  1
// @grant    none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require      https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play-audio.js
// @require      https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/html_functions.js
// @include  https://yandex.ru/search/*
// ==/UserScript==

var $ = window.jQuery;


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
  clearPage("результатов поиска");
  
  document.body.style="";
  document.body.setAttribute("class","");
  document.body.setAttribute("style","");
  document.body.setAttribute("data-bem","");
  document.body.setAttribute("data-log-node","");
  
  
  // Прикрепляю воссозданный список результатов
  document.body.appendChild(newResultsContainer);
  
});


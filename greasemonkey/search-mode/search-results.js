// ==UserScript==
// @name     ������ (���������� ������)
// @version  1
// @grant    none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @include  https://yandex.ru/search/*
// ==/UserScript==

var $ = window.jQuery;

function playAudio(audioURL){
  var audioTag = document.createElement('audio');
  audioTag.src = audioURL;
  audioTag.play();
}


$(document).ready(function(e){

  // �������� �� ���������� ������
  playAudio('http://127.0.0.1/search-complete.mp3');
  
  
  // ������� �� ��������, � �������� ����� ��������� ���������� ��������� ������
  var topContainer = document.querySelector('.content__left');
  
  
  // HTML-������� ��������� ����� �����������
  var newResultsContainer = document.createElement('UL');
    newResultsContainer.id = 'newResultsContainer';
    newResultsContainer.style.listStyleType = 'none';
    newResultsContainer.style.borderStyle = 'dashed';
    newResultsContainer.style.borderWidth = 4;
    newResultsContainer.style.borderColor = 'limegreen';
    newResultsContainer.style.width = '100%';
  	newResultsContainer.style.lineHeight = '2em';
    newResultsContainer.style.fontSize = '200%';
  
  
  // ������� ������ �� ��������
  var linkItems = document.querySelectorAll('A.organic__url');
  //alert("linkItems.length="+linkItems.length);
  
  
  // ����������� ������
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
  
  
  // ������ ��������
  document.body.innerHTML = "";
  document.body.style="";
  document.body.setAttribute("class","");
  document.body.setAttribute("style","");
  document.body.setAttribute("data-bem","");
  document.body.setAttribute("data-log-node","");
  
  
  // ���������� ������������ ������ �����������
  document.body.appendChild(newResultsContainer);
  
});


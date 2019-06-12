// ==UserScript==
// @name     Яндекс.Почта (сообщение)
// @version  1
// @grant    none
// @include  https://mail.yandex.ru/lite/message/*
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var DEBUG = false;

function debugMsg(msg){
  if (DEBUG) console.log(msg);
}

function fetchSubject(){
  let text = $('.b-message-head__subject-text').text();
  debugMsg(text);
  return text;
}

function fetchBody(){
  let text = $('.b-message-body__content').text();
  debugMsg(text);
  return text;
}

function fetchDate(){
  let text = $('.b-message-head__date').text();
  debugMsg(text);
  return text;
}

function fetchAttachmentsCount(){
  let cnt = $('.b-message-attach__i').length;
  debugMsg("вложений: "+cnt);
  return cnt;
}

function clearAttachments(){
  $('div.b-message-attach').each( function(index,element){
    element.remove();
  });
}

function buildLine(text){
  return $("<li><a href='#' class='qwerty'>"+text+"</a></li>");
}

function constructNewPage(msgSubject, msgBody, msgDate, attachmentsCount){
  debugMsg("constructNewPage()");
  
  console.log("ДАТА-1: "+msgDate);
  let humanDate = humanizeDate(msgDate);
  console.log("ДАТА-2: "+humanDate);
  
  let listId = "oneMessage";
  
  $('body').append("<UL id='"+listId+"'></UL>");
  
  let attachmentsMsg = (0==attachmentsCount) ? "вложений нет" : "вложения: "+attachmentsCount+" штуки";
  
  //$('#'+listId).append("<a id='hello' href='#'>Привет, прочти письмо</a>");
  
  //$('#'+listId).append( buildLine("Письмо от "+humanDate+", "+attachmentsMsg) );
  $('#'+listId).append( buildLine("Письмо от "+humanDate) );
  
  $('#'+listId).append( buildLine("Заголовок: "+msgSubject) );
  
  let bodyMsg = (msgBody.match(/^\s*$/)) ? "пустое сообщение" : msgBody;
  $('#'+listId).append( buildLine("Сообщение: "+bodyMsg) );
}


// ============ Когда документ загружен ===============
$(document).ready(function(){
  playAudio('http://127.0.0.1/email-opened.mp3');
  
  let attachmentsCount = fetchAttachmentsCount();
  clearAttachments(); // это нужно делать ДО получения тела сообщения

  let msgSubject = fetchSubject();
  let msgBody = fetchBody();
  let msgDate = fetchDate();
  
  let singleTextMessage = "";
  singleTextMessage += msgSubject + "\n";
  singleTextMessage += msgBody + "\n";
  singleTextMessage += msgDate + "\n";
  
  singleTextMessage += "\n" + "Чтобы прослушать письмо в ручном режиме, используйте навигационные клавиши." + "\n";
  
  document.title = "Письмо: "+msgSubject;
  
  clearPage();
  
  $('body').append("<textarea onclick='this.select()' style='width:80%; height: 200px;'>"+singleTextMessage+"</textarea>");
  
  constructNewPage(msgSubject, msgBody, msgDate, attachmentsCount);
  
});

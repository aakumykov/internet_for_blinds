// ==UserScript==
// @name Яндекс.Почта (сообщение)
// @namespace Violentmonkey Scripts
// @include  /^https://mail\.yandex\.ru/lite/message/\d+$/
// @grant none
// @inject-into content 
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

console.log("Яндекс.Почта загружена");


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

    //console.log("ДАТА-1: "+msgDate);
    let humanDate = humanizeDate(msgDate);
    //console.log("ДАТА-2: "+humanDate);
  
    let listId = "oneMessage";
  
    $('body').append("<button id='button3'>Три шага до письма</button><br>");
    $('body').append("<button id='button2'>Два шага до письма</button><br>");
    $('body').append("<button id='button1'>Один шаг до письма</button><br>");
    $('body').append("<br>");
    
    $('body').append("<UL id='"+listId+"'></UL>");
    
    let attachmentsMsg = (0==attachmentsCount) ? "вложений нет" : "вложения: "+attachmentsCount+" штуки";
    let dateLine = buildLine("Письмо от "+humanDate);
    let subjectLine = buildLine("Заголовок: "+msgSubject);
    let bodyLine = (msgBody.match(/^\s*$/)) ? "пустое сообщение" : "Сообщение: "+msgBody;
  
  
    
    ////$('#'+listId).append( buildLine("Письмо от "+humanDate+", "+attachmentsMsg) );
    $('#'+listId).append(dateLine);
    $('#'+listId).append(subjectLine);
    $('#'+listId).append( buildLine("Сообщение: "+bodyLine) );

    
  /*let fullText = 
      dateLine.text() + ". <br>" +
      subjectLine.text() + ". <br>" +
      bodyLine
      ;*/
    
    //$(document.body).append("<a id='linkWithFullText' href='#'>"+fullText+"</a>");
    
    //$('#button1').focus();
  
    /*setTimeout(function(){
        $('#linkWithFullText').focus();
    }, 2000);*/
}


// ============ Основная логика ===============

playAudio('http://127.0.0.1/email-opened.mp3');

let attachmentsCount = fetchAttachmentsCount();
clearAttachments(); // это нужно делать ДО получения тела сообщения

let msgSubject = fetchSubject();
let msgBody = fetchBody();
let msgDate = fetchDate();

document.title = "Письмо: "+msgSubject;

clearPage();

constructNewPage(msgSubject, msgBody, msgDate, attachmentsCount);

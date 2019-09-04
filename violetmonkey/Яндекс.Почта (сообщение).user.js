// ==UserScript==
// @name Яндекс.Почта (сообщение)
// @namespace Violentmonkey Scripts
// @include  /^https://mail\.yandex\.ru/lite/message/\d+/
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
    let bodyText = $('.b-message-body__content').text();
    debugMsg(bodyText);
    return bodyText;
}

function fetchBodyHTML() {
    return $('.b-message-body__content').html();
}

function createBodyWithMultipleLines(listId, bodyHTML) {
    let bodyParts = bodyHTML.split("<br>");
    
    for (let i=0; i<bodyParts.length; i++) {
        let part = bodyParts[i].trim();
        if ("" != part) {
            let lineText = $("<p>"+part+"</p>").text();
            $('#'+listId).append( buildLine(lineText) );
        }
    }
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

function fetchAttachmentsList() {
    let list = [];
    $('.b-message-attach__info').each(function(i){
        list[list.length] = $(this).text().trim();
    });
    return list;
}

function clearAttachments(){
  $('div.b-message-attach').each( function(index,element){
    element.remove();
  });
}

function buildLine(text){
  return $("<li><a href='#' class='qwerty'>"+text+"</a></li>");
}

function pluralAttachmentsTitle(count) {
    if (1==count) {
        return "прикреплён "+count+" файл:";
    }
    else if (count > 1 && count <= 4) {
        return "прикреплено "+count+" файла:";
    }
    else {
        return "прикреплено "+count+" файлов:";
    }
}

function constructNewPage(msgSubject, bodyHTML, msgDate, attachmentsList){
    console.log(bodyHTML);
    
    debugMsg("constructNewPage()");

    //console.log("ДАТА-1: "+msgDate);
    let humanDate = humanizeDate(msgDate);
    //console.log("ДАТА-2: "+humanDate);
  
    let listId = "oneMessage";
  
    //$('body').append("<button id='button3'>Три шага до письма</button><br>");
    //$('body').append("<button id='button2'>Два шага до письма</button><br>");
    //$('body').append("<button id='button1'>Один шаг до письма</button><br>");
    $('body').append("<br>");
    
    $('body').append("<UL id='"+listId+"'></UL>");
    
    let dateLine = buildLine("Письмо от "+humanDate);
    let subjectLine = buildLine("Заголовок: "+msgSubject);
    
    //let bodyLine = (msgBody.match(/^\s*$/)) ? "пустое сообщение" : "Сообщение: "+msgBody;
    
    //let repliedMessageIndex = bodyLine.indexOf("-----Original Message-----");
    //bodyLine = bodyLine.substr(0, repliedMessageIndex);
    
    ////$('#'+listId).append( buildLine("Письмо от "+humanDate+", "+attachmentsMsg) );
    $('#'+listId).append(dateLine);
    $('#'+listId).append(subjectLine);
    
    // вложения
    let attCount = attachmentsList.length;
    if (attCount > 0) {
        $('#'+listId).append( buildLine(pluralAttachmentsTitle(attCount)) );
        for (let i=0; i<attCount; i++) {
            let attName = attachmentsList[i].trim();
            $('#'+listId).append( buildLine(attName) );
        }
    }
    else {
        $('#'+listId).append( buildLine("прикреплённых файлов нет") );
    }
    
    $('#'+listId).append( buildLine("Текст сообщения:") );
    createBodyWithMultipleLines(listId, bodyHTML);
    
    $('#'+listId).append( buildLine("конец сообщения") );
}


// ============ Основная логика ===============

playAudio('http://127.0.0.1/email-opened.mp3');

let attachmentsCount = fetchAttachmentsCount();
let attachmentsList = fetchAttachmentsList();
//console.log("attachmentsList: "+attachmentsList);
clearAttachments(); // это нужно делать ДО получения тела сообщения

let msgSubject = fetchSubject();
let bodyHTML = fetchBodyHTML();
let msgDate = fetchDate();

document.title = "Письмо: "+msgSubject;

clearPage("письма");

constructNewPage(msgSubject, bodyHTML, msgDate, attachmentsList);

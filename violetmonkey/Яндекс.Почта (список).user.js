// ==UserScript==
// @name     Яндекс.Почта (список)
// @version  1
// @grant    none
// @inject-into content
// @include	   /^https://mail\.yandex\.ru/lite$/
// @include	   /^https://mail\.yandex\.ru/lite/$/
// @inject-into content
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

// Системная настройка JQuery
var $ = window.jQuery;


// ========= Функции обработки почты ========
var schema = 'https://';
var host = 'mail.yandex.ru';
var list = [];

// --- Поиск элементов ---
function fetchDate(element) {
  return $(element).find('.b-messages__date').find('span').first().text();
}

function fetchTitle(element) {
  return $(element).find('.b-messages__subject').first().text();
}

function fetchFrom(element) {
  return $(element).find('.b-messages__from__text').find('span').first().text();
}

function fetchLink(element) {
  return $(element).find('.b-messages__message__link').attr('href');
}

function fetchMessageList() {
  $('.b-messages__message').each( function(index, line) {
    var date = fetchDate(line);
    var title = fetchTitle(line);
    var from = fetchFrom(line);
    var link = fetchLink(line);
    //console.log(from+" - "+date+" - "+title+" ("+schema+host+link+")");
    list.push({
      'date': date,
      'title': title,
      'from': from,
      'link': link
    });
  });
}


// --- Создание новых элементов ---
function createMessageLine(date, from, title, link) {
    //console.log("DATE: "+date);

    let linePrefix = "Письмо, от ";
    let humanDate = humanizeDate(date);
    
    let li = $("<LI>");
    
    let a = $("<A>");
        a.append(linePrefix+" "+humanDate+", прислал "+from+", заголовок: "+title);
        a.attr("href", link);
        a.attr("target", '_blank');
        a.click(function(){ playAudio("http://127.0.0.1/mail-is-opening.mp3"); });
    
    li.append(a);
    
    return li;
}

function createMessageList() {
  $('body').append("<UL id='messageList'></UL>");

  for(var i=0; i<list.length; i++) {
    var item = list[i];
    //console.log(item.title);
    $('#messageList').append( createMessageLine(item.date, item.from, item.title, item.link) );
  }
}


// ================ Работа =================
playAudio('http://127.0.0.1/mail-has-opened.mp3');
fetchMessageList();
clearPage("списка сообщений");
createMessageList();
$('#startPoint4').focus();

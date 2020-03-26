// ==UserScript==
// @name ФИПС: просмотр заявки
// @namespace Violentmonkey Scripts
// @include /^https://www\.fips\.ru/registers-doc-view/fips_servlet\?DB=(RUPMAP|RUPAT)/
// https://www.fips.ru/registers-doc-view/fips_servlet?DB=RUPMAP
// @grant none
// @inject-into content
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

vocalizePageType();

let data = collectData();
let ticketNumber = findTicketNumber();

clearPage();

constructNewPage(ticketNumber, data);
console.log(data);


// Функции
// 
function vocalizePageType() {
    if (isIZ()) {
        console.log("Изобретениеь");
        playAudio("http://127.0.0.1/fips-invention.mp3");
    }
    else if (isPM()) {
        console.log("Полезная модель");
        playAudio("http://127.0.0.1/fips-utility-model.mp3");
    }
    else {
        console.log("Неизвестный тип страницы");
        playAudio("http://127.0.0.1/fips-unknown-type-of-page.mp3");
    }
}

function isPM() {
    //return location.href.match(/DB=RUPMAP/).length == 1;
    let m = location.href.match(/DB=RUPMAP/);
    return null != m && m.length == 1;
}

function isIZ() {
    let m = location.href.match(/DB=RUPAT/);
    return null != m && m.length == 1;
}

function isEmpty(text) {
    return 0 == text.trim().length;
}

function findTicketNumber() {
    return $("#top4").text();
}

function collectData() {
    let deloTableRows = $("table#delo").find("TR");

    let data = {
        inbox: [],
        outbox: []
    };

    for (let i=1; i<deloTableRows.length; i++) {
        let rowCells = $(deloTableRows[i]).find("TD");
        
        let title1 = $(rowCells[0]).text();
        let date1 = $(rowCells[1]).text();
        if (!isEmpty(title1))
            data.outbox[data.outbox.length] = title1 + " " + date1;
        else
            console.log("title1 is empty");
        
        
        let title2 = $(rowCells[2]).text();
        let date2 = $(rowCells[3]).text();
        if (!isEmpty(title2))
            data.inbox[data.inbox.length] = title2 + " " + date2;
        else
            console.log("title2 is empty");
    }

    //console.log("=== outbox ==="); console.log(data.outbox);
    //console.log("=== inbox ==="); console.log(data.inbox);
    
    return data;
}

function constructNewPage(number, data) {    
    makePageName(number);
    buildCorrespondentionBlock("Что делают они", data.outbox);
    buildCorrespondentionBlock("Что отправили вы", data.inbox);
    
    $('body').append("<button>Конец страницы</button>");
}

function makePageName(ticketNumber) {
    $('body').append("<button>Заявка номер "+ticketNumber+"</button><br><br>");
}

function buildCorrespondentionBlock(title, data) {
    let body = $('body');
    
    if (data.length > 0) {
        body.append("<button>"+title+"</button><br>");
        for (let k=0; k<data.length; k++) 
            body.append("<a href=''>"+data[k]+"</a><br>");
    }
    else {
        body.append("<button>"+title+": пусто</button><br>");
    }
    
    $('body').append("<br><br>");
}


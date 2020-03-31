// ==UserScript==
// @name ФИПС-02-список-заявок
// @namespace Violentmonkey Scripts
// @include /^https://kpsrtz\.fips\.ru/$/
// @grant none
// @inject-into content
// @require    https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var $ = window.jQuery;

var observer = new MutationObserver(function(mutations) {
    let data = collectData();
    clearPage("списка заявок");
    constructNewPage(data);
});

observer.observe(document.querySelector("div.data-content"), {childList: true, subtree: true, attributes: false, characterData: false});


function collectData() {
    
    let list = [];
    
    $("div.item").each(function(index, element){
        
        //console.log("index: "+index);
        
        let lineElements = $(element).find("DIV");
        
        let requestObject = {
            registrationDate: $(lineElements[0]).text().trim(),
            regNum: $(lineElements[1]).text().trim(),
            inboxNum: $(lineElements[2]).text().trim(),
            senfNum: $(lineElements[3]).text().trim(),
            creationDate: $(lineElements[4]).text().trim(),
        }
        
        list[list.length] = requestObject;
        
    });
    
    return list;
}

function constructNewPage(data) {
    if (0 == data.length) {
        playAudio("http://127.0.0.1/fips-arm-registrator-error-getting-requests-list.mp3");
        playAudio("http://127.0.0.1/fips-arm-retrying-after-15-seconds.mp3");
        
        $('body').append("<h2>Не удалось прочитать список заявок. Повтор через 15 секунд.</h2>");
        
        window.setTimeout(function(){
            window.location.href="https://kpsrtz.fips.ru/User/Login";
        }, 15000);
        
        return;
    }
    
    //console.log(data);
    
    $('body').append("<h2>Библиотека заявок</h2>");
    
    $('body').append("<ul>");
    
    for (let i=0; i<data.length; i++) {
        let dataRow = data[i];
        //console.log(dataRow);
        
        let line = "<li>";
        line += "<a ";
        line += " target='_blank' ";
        line += " href='";
        line += "https://kpsrtz.fips.ru/Application/Documents/";
        line += dataRow.regNum;
        line += "'>";
        line += "Заявка номер "+dataRow.regNum;
        line += "</a></li>";
        
        $('body').append(line);
    }
    
    $('body').append("<li><a href=''>Конец списка заявок</a></li>");
    $('body').append("</ul>");
    
    playAudio("http://127.0.0.1/fips-arm-registrator-requests-list-is-opened.mp3");
    
    document.querySelector("#startPoint4").focus();
}
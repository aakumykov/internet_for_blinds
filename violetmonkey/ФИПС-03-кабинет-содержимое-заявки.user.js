// ==UserScript==
// @name ФИПС-03-кабинет-содержимое-заявки
// @namespace Violentmonkey Scripts
// @include /^https://kpsrtz\.fips\.ru/Application/Documents/[0-9]+$/
// @grant none
// @inject-into content
// @require    https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==


var $ = window.jQuery;

console.log("ФИПС-03-кабинет-содержимое-заявки");

let changesNumber = 0;

let observer = new MutationObserver(function(mutations) {
    console.log("обнаружены изменения "+changesNumber+", "+mutations.length);
    
    changesNumber++;
    
    if (0 == changesNumber && mutations.length > 40) {
        console.log("Не сработало, обновляем");
        
        window.setTimeout(function(){
            window.location.reload();
        }, 3000);
        
        return;
    }
    
    
    if (1 == changesNumber) {
        console.log("можно обрабатывать");
        let data = collectData();
        clearPage("до содержимого заявки");
        constructNewPage(data);
    }
});

observer.observe(
    document.querySelector("div.data-content"), 
    {childList: true, subtree: true, attributes: false, characterData: false}
);



function collectData() {
    console.log("collectData()");
    
    let list = [];
    
    $("div.item").each(function(index, element){
        
        let lineElements = $(element).find("DIV");
        
        let requestObject = {
            name: $(lineElements[1]).text().trim(),
            creationDate: $(lineElements[2]).text().trim(),
            registrationDate: $(lineElements[3]).text().trim(),
            state: $(lineElements[4]).text().trim(),
        }
        
        list[list.length] = requestObject;
        
    });
    
    return list;
}


function constructNewPage(data) {
    console.log("constructNewPage()");
    
    if (0 == data.length) {
        playAudio("http://127.0.0.1/fips-arm-registrator-error-request-content.mp3");        
        $('body').append("<h2>Не удалось прочитать содержимое заявки. Закройте страницу и попробуйте ещё раз.</h2>");
        return;
    }
    
    //console.log(data);
    
    $('body').append("<h2>Заявка на изобретение/полезную модель</h2>");
    
    $('body').append("<ul>");
    
    for (let i=0; i<data.length; i++) {
        let dataRow = data[i];
        
        //console.log(dataRow);
        
        let line = "<li><a  target='_blank' href=''>";
        line += dataRow.name;
        line += ", создано " + dataRow.creationDate;
        if (dataRow.registrationDate && "" != dataRow.registrationDate.trim()) line += ", зарегистрировано " + dataRow.registrationDate;
        line += ", статус: " + dataRow.state;
        line += "</a></li>";
        
        $('body').append(line);
    }
    
    $('body').append("<li><a href=''>Конец заявки</a></li>");
    $('body').append("</ul>");
    
    playAudio("http://127.0.0.1/fips-arm-registrator-request-content-is-opened.mp3");
    
    document.querySelector("#startPoint2").focus();
}


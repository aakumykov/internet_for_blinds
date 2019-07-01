// ==UserScript==
// @name Яндекс.Поиск (результаты)
// @namespace Violentmonkey Scripts
// @include /^https://yandex\.ru/search/\?/
// @grant none
// @inject-into content
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require          https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

// ------------------------ Подготовка ------------------------
var $ = window.jQuery;

// ------------------------ Основная работа ------------------------

playAudio('http://127.0.0.1/search-complete.mp3');

let results_links = collectLinks("a.organic__url", "div.organic__url-text");
console.log(results_links);

let next_pages_links = collectLinks("a.pager__item");
console.log(next_pages_links);

clearPage(null);
createList(results_links,    null, "Первые 10 результатов поиска", null, null, null, "http://127.0.0.1/page-is-opening.mp3");
createList(next_pages_links, null, "Другие результаты поиска",     null, "Страница результатов ", null, "http://127.0.0.1/search-results-next-page-is-opening.mp3");


// ------------------------- Функции ------------------------

function clearPage(newTitle) {
    let documentCorpus = $('body');
    
    documentCorpus.empty();
    documentCorpus.append("<br><button id='startPoint'>*</button><br><br>");
    
    if (null != newTitle)
        documentCorpus.append("<br><button id='startPoint'>"+newTitle+"</button><br><br>");
}

function collectLinks(linkNodeSelector, linkTextSelector, linkDateSelector) {
    //let args = [];
    //for (let key in arguments) args.push(arguments[key]);
    //console.log("collectLinks("+args.join(", ")+")");
    
    let list = {};
    
    $(linkNodeSelector).each(function(index, element){
        let address = $(element).attr('href');
        
        let name = (null != linkTextSelector) ? $(element).find(linkTextSelector).text() : $(element).text();
        
        if (null != linkDateSelector) {
            let date = $(element).find(linkDateSelector).text();
            name = name+", "+date;
        }
        
        list[name] = address;
    });
    
    return list;
}

function createList(listHash, baseUrl, listStartText, listEndText, linkNamePrefix, linkNameSuffix, openingSoundLink) {
    let documentCorpus = $('body');
    
    //document.title = listStartText;
    documentCorpus.append("<br><button>"+listStartText+"</button><br>");
    
    for (let name in listHash) {

        if (listHash.hasOwnProperty(name)) {

            let value = listHash[name];
            
            let linkText = name;
            if (null != linkNamePrefix) linkText = linkNamePrefix + linkText;
            if (null != linkNameSuffix) linkText = linkText + linkNameSuffix;
            
            let a = $('<A><br>');
            a.append(linkText);
            
            let address = (null != baseUrl) ? baseUrl + value : value;
            a.attr('href', address);
                
            a.attr('target', '_blank');

            if (null != openingSoundLink) {
                a.click(function(){ playAudio(openingSoundLink); });
            }
            
            documentCorpus.append(a);
        }
    }
    
    if (null != listEndText)
        documentCorpus.append("<br><br><button id='startPoint'>"+listEndText+"</button><br><br>");
    else 
        documentCorpus.append("<br><br>");
    
    //$('#startPoint').focus();
}

function addLink(text, href, onClickSoundLink) {
    addLinkExtended(text, href, "_blank", "body", "");
}

function addLinkWithSound(text, href, onClickSoundLink) {
    addLinkExtended(text, href, "_blank", "body", onClickSoundLink);
}

function addLinkExtended(text, href, target, parentNodeSelector, onClickSoundLink) {
    let a = $("<A>");
        a.append(text);
        a.attr("href", href);
        a.attr('target', target);
        if ("" != onClickSoundLink) {
            a.click(function(){
                playAudio(onClickSoundLink);
            });
        }
    $("body").append(a);
    $("body").append("<br><br>");
}

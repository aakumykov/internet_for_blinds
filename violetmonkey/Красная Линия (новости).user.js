// ==UserScript==
// @name Красная Линия (новости)
// @namespace Violentmonkey Scripts
// @match https://www.rline.tv/news/
// @grant none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require			 https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var $ = window.jQuery;

// ====================
playAudio('http://127.0.0.1/redline-news.mp3');
let channelName = $('.content-left > h1:nth-child(1)').text();
let links = collectLinks('.news__item', '.news__item-name');
createPageWithLinks(links, "Новости сайта Красная Линия", "Конец списка новостей");
// ====================


function collectLinks(linkNodeSelector, linkTextSelector) {
    let list = {};
    let baseURL = 'https://www.rline.tv';
    
    $(linkNodeSelector).each(function(index, element){
        let name = $(element).find(linkTextSelector).text();
        let address = baseURL + $(element).attr('href');
        list[name] = address;
    });
    
    return list;
}

function createPageWithLinks(linksHashMap, startText, endText) {
    let documentCorpus = $('body');
    
    documentCorpus.empty();
    documentCorpus.append("<button id='startPoint'>*</button><br><br>");
    
    document.title = startText;
    documentCorpus.append("<button>"+startText+"</button><br><br>");
    
    for (let key in linksHashMap) {
        if (linksHashMap.hasOwnProperty(key)) {
            let value = linksHashMap[key];
            documentCorpus.append("<a href='"+value+"' target='_blank'>"+key+"</a><br>");
        }
    }
    
    documentCorpus.append("<br><br><button id='startPoint'>"+endText+"</button>");
    
    $('#startPoint').focus();
}

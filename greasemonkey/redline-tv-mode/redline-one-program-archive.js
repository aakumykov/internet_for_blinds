// ==UserScript==
// @name Красная Линия (передачи выбранного канала)
// @namespace Violentmonkey Scripts
// @include /^https://www\.rline\.tv/programs/[^/]+/$/
// @grant none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require          https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==
// 
var $ = window.jQuery;

// ====================
playAudio('http://127.0.0.1/redline-program-archive-opened.mp3');
let channelName = $('.content-left > h1:nth-child(1)').text();
let links = collectLinks('.video-list__item', '.video-list__name');
disableStyles();
createPageWithLinks(links, "Архив телепередачи «"+channelName+"»", "Конец архива телепередачи «"+channelName+"»", "http://127.0.0.1/video-is-opening.mp3");
//createList(links, "Архив телепередачи «"+channelName+"»", "Конец архива телепередачи «"+channelName+"»", null, "http://127.0.0.1/video-is-opening.mp3")
// ====================

function disableStyles() {
    for (let i=0; i<document.styleSheets.length; i++) {
        document.styleSheets[i].disabled = true;
    }
}

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

function createPageWithLinks(linksHashMap, startText, endText, openingSoundLink) {
    let documentCorpus = $('body');
    
    documentCorpus.empty();
    documentCorpus.append("<button id='startPoint'>*</button><br><br>");
    
    document.title = startText;
    documentCorpus.append("<button>"+startText+"</button><br><br>");
    
    for (let key in linksHashMap) {
        if (linksHashMap.hasOwnProperty(key)) {
            let value = linksHashMap[key];
            //documentCorpus.append("<a href='"+value+"' target='_blank'>"+key+"</a><br>");
            
            let a = $("<A><br>");
                a.append(key);
                a.attr("href", value);
                a.attr("target", "_blank");
            
            if (null != openingSoundLink)
                a.click(function() { playAudio(openingSoundLink); });
            
            documentCorpus.append(a);
        }
    }
    
    documentCorpus.append("<br><br><button id='startPoint'>"+endText+"</button>");
    
    $('#startPoint').focus();
}

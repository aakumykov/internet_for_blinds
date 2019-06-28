// ==UserScript==
// @name Красная Линия (список передач)
// @namespace Violentmonkey Scripts
// @match https://www.rline.tv/programs/
// @grant none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require			 https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var $ = window.jQuery;

$(document).ready(function(){
    playAudio('http://127.0.0.1/redline-channels-list-opened.mp3');
    let channels = collectLinks();
    createPageWithLinks(channels);
});

function collectLinks() {
    let channels = {};
    
    $('.video-list__program').each(function(index, element){
        let baseURL = 'https://www.rline.tv';
        
        let channelName = $(element).find('.video-list__program-name').text();
        let channelAddress = baseURL + $(element).attr('href');
        
        channels[channelName] = channelAddress;
    });
    
    return channels;
}

function createPageWithLinks(linksHashMap) {
    let documentCorpus = $('body');
    
    documentCorpus.empty();
    documentCorpus.append("<button id='startPoint'>*</button><br><br>");
    
    let pageName = "Список программ телеканала Красная линия";
    document.title = pageName;
    documentCorpus.append("<button>"+pageName+"</button><br><br>");
    
    for (let key in linksHashMap) {
        if (linksHashMap.hasOwnProperty(key)) {
            let value = linksHashMap[key];
            //console.log(key+" --> "+value);
            documentCorpus.append("<a href='"+value+"' target='_blank'>"+key+"</a><br>");
        }
    }
    
    documentCorpus.append("<br><br><button id='startPoint'>Конец списка программ</button>");
    
    $('#startPoint').focus();
}

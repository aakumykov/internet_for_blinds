// ==UserScript==
// @name Красная Линия (список передач)
// @namespace Violentmonkey Scripts
// @include      /^https://www\.rline\.tv/programs/$/
// @grant none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require			 https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var $ = window.jQuery;

$(document).ready(function(){
    playAudio('http://127.0.0.1/redline-channels-list-has-opened.mp3');
    let links = collectLinks('.video-list__program', '.video-list__program-name');
    clearPage();
    createList(links, "Список программ телеканала Красная линия", "Конец списка программ", " (программа)");
});


function clearPage(newTitle) {
    let documentCorpus = $('body');
    documentCorpus.empty();
    if (null == newTitle) newTitle = "*";
    documentCorpus.append("<br><button id='startPoint'>*</button><br><br>");
    documentCorpus.append("<br><button id='startPoint'>"+newTitle+"</button><br><br>");
}

function collectLinks(linkNodeSelector, linkTextSelector, linkDateSelector) {
    let list = {};
    let baseURL = 'https://www.rline.tv';
    
    $(linkNodeSelector).each(function(index, element){
        let address = baseURL + $(element).attr('href');
        let name = $(element).find(linkTextSelector).text();
        
        if (null != linkDateSelector) {
            let date = $(element).find(linkDateSelector).text();
            name = name+", "+date;
        }
        
        list[name] = address;
    });
    
    return list;
}

function createList(listHash, listTitle, listFinishText, linkNameSuffix, openingSoundLink) {
    let documentCorpus = $('body');
    
    //document.title = listTitle;
    documentCorpus.append("<br><button>"+listTitle+"</button><br>");
    
    for (let name in listHash) {

        if (listHash.hasOwnProperty(name)) {

            let value = listHash[name];
            
            let a = $('<A><br>');
                a.append(name + linkNameSuffix);
                a.attr('href', value);
                a.attr('target', '_blank');
            
                if (null != openingSoundLink) {
                    a.click(function(){ playAudio(openingSoundLink); });
                }
            
            documentCorpus.append(a);
        }
    }
    
    documentCorpus.append("<br><br><button id='startPoint'>"+listFinishText+"</button><br><br>");
    
    //$('#startPoint').focus();
}

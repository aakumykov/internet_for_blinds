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

let links = collectLinks('.news__item', '.news__item-name');

clearPage();
disableStyles();

createList(links, "Новости сайта Красная Линия", "Конец списка новостей", " (новость)", "http://127.0.0.1/redline-news-item-is-opening.mp3");

// ====================

function disableStyles() {
    for (let i=0; i<document.styleSheets.length; i++) {
        document.styleSheets[i].disabled = true;
    }
}

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
    documentCorpus.append("<br><button>"+listTitle+"</button><br><br>");
    
    for (let name in listHash) {

        if (listHash.hasOwnProperty(name)) {

            let value = listHash[name];
            
            let a = $('<A></A><br>');
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
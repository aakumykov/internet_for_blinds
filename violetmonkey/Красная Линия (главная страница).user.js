// ==UserScript==
// @name Красная Линия (главная страница)
// @namespace Violentmonkey Scripts
// @include /^https://www\.rline\.tv/$/
// @grant none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require          https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// @require      https://raw.githubusercontent.com/aakumykov/internet_for_blinds/mode-stack/javascript/lib/html_functions.js
// ==/UserScript==

var $ = window.jQuery;

// ====================
playAudio('http://127.0.0.1/redline-has-opened.mp3');

let newVideosLinks = collectLinks('.video-list__item', '.video-list__name');
let newsLinks = collectLinks('.news__item', '.news__item-name', '.news__item-date');

//clearPage("Телеканал красная линия");
//disableStyles();

clearPage2("Телеканал красная линия", null);

addLinkWithSound("Телепередачи канала Красная Линия (подраздел)", "https://www.rline.tv/programs/", "http://127.0.0.1/redline-channels-list-is-opening.mp3");
addLinkWithSound("Все новости сайта Красная Линия (подраздел)", "https://www.rline.tv/news/", "http://127.0.0.1/redline-news-is-opening.mp3");

createList(newVideosLinks, "Новые видео", "Конец новых видео", " (видеоролик)", "http://127.0.0.1/opening-video.mp3");
createList(newsLinks, "Последние новости", "Конец списка последних новостей", "", "http://127.0.0.1/opening-link.mp3");

// ====================

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

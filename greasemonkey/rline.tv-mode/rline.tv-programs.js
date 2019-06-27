// ==UserScript==
// @name rline.tv/programs
// @namespace Violentmonkey Scripts
// @match https://www.rline.tv/programs/*/
// @grant none
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require			 https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var $ = window.jQuery;

$(document).ready(function(){
    playAudio('http://127.0.0.1/redline-channel-opened.mp3');
    let channels = collectLinks();
    createPageWithLinks(channels);
});
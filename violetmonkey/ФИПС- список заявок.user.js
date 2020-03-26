// ==UserScript==
// @name ФИПС: список заявок
// @namespace Violentmonkey Scripts
// @include http://127.0.0.1/fips-status/patent-request-statuses.html
// @grant none
// @inject-into content
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/date_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/html_functions.js
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

//var $ = window.jQuery;

playAudio('http://127.0.0.1/fips-resuests-list-is-opened.mp3');

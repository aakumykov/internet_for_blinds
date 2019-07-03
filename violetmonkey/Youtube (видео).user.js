// ==UserScript==
// @name     Youtube (видео)
// @version  1
// @grant    none
// @inject-into content
// @include	   /^https://www\.youtube\.com/watch/
// @inject-into content
// @require  https://raw.githubusercontent.com/aakumykov/internet_for_blinds/master/greasemonkey/lib/play_audio.js
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// ==/UserScript==

var $ = window.jQuery;

//$('video.html5-main-video').get(0).pause()

//playAudio("http://127.0.0.1/video-has-opened.mp3")

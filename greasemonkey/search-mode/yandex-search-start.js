// ==UserScript==
// @name     Яндекс (начало поиска)
// @version  1
// @grant    none
// @match    https://ya.ru/
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require      https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==

var $ = window.jQuery;

var observer = new MutationObserver(function(mutations) {
  //console.log('Изменений: '+mutations.length);

  mutations.forEach(function(oneMutation){
    //console.log(oneMutation.target.className);
    
    if (questionAwaited(oneMutation)) {
      console.log("========= НАЧИНАЙТЕ ГОВОРИТЬ ============");
    }
    
    if (questionAccepted(oneMutation)) { 
      console.log("============ ВОПРОС ПРИНЯТ ============="); 
    }
    
    if (questionMissed(oneMutation)) { 
      console.log("============ ВОПРОС ОТСУТСТВУЕТ ============="); 
    }
  });

});

$(document).ready(function(){
  console.log("ДОКУМЕНТ ЗАГРУЖЕН");
  observer.observe(document.body,{childList: true, subtree: true, attributes: true, characterData: false});
  //activateVoiceSearch();
  playAudio('http://127.0.0.1/what-you-want-to-find.mp3', activateVoiceSearch);
});

function activateVoiceSearch(){
  $('DIV.input__voice-search').trigger('click');
}

// Аргумент - объект "Mutation" из MutationObserver.
function questionAwaited(oneMutation) {
  var className = oneMutation.target.className; 
  if (className.match("voice-search-popup_speechkit-state_start")) {
    if (className.match("voice-search-popup_state_opened")) {
      return true;
    }
  }
  return false;
}

function questionAccepted(oneMutation) {
  var className = oneMutation.target.className; 
  if (className.match("voice-search-popup_state_opened")) {
    if (className.match("voice-search-popup_speechkit-state_recognized")) {
      return true;
    }
  }
  return false;
}

function questionMissed(oneMutation) {
  var className = oneMutation.target.className; 
  if (className.match("voice-search-popup_speechkit-state_start")) {
    if (className.match('voice-search-popup_state_closed')) {
      return true;
    }
  }
  return false;
}

//voice-search-popup voice-search-popup_state_opened i-bem voice-search-popup_js_inited voice-search-popup_speechkit-state_access
//voice-search-popup voice-search-popup_state_opened i-bem voice-search-popup_js_inited voice-search-popup_speechkit-state_init
//voice-search-popup voice-search-popup_state_opened i-bem voice-search-popup_js_inited voice-search-popup_speechkit-state_start
//voice-search-popup voice-search-popup_state_opened i-bem voice-search-popup_js_inited voice-search-popup_speechkit-state_error

//voice-search-popup voice-search-popup_state_closed i-bem voice-search-popup_js_inited voice-search-popup_speechkit-state_start
  
//voice-search-popup_state_closed voice-search-popup_speechkit-state_start
//voice-search-popup_state_opened voice-search-popup_speechkit-state_start

//voice-search-popup_speechkit-state_recognized

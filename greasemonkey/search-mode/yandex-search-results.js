// ==UserScript==
// @name     ßíäåêñ (ïîèñê)
// @version  1
// @grant    none
// @match	   https://ya.ru/
// @require      https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// ==/UserScript==

var $ = window.jQuery;

function playAudio(audioURL, completeCallback){
  var audioTag = document.createElement('audio');
  audioTag.src = audioURL;
  
  if (null!=completeCallback) audioTag.addEventListener('ended', function(){completeCallback();}, true);
  else console.log("completeCallback is NULL");
  
  audioTag.play();
}

var observer = new MutationObserver(function(mutations) {
	//console.log('Èçìåíåíèé: '+mutations.length);

  mutations.forEach(function(oneMutation){
    //console.log(oneMutation.target.className);
    
    if (questionAwaited(oneMutation)) {
      console.log("========= ÍÀ×ÈÍÀÉÒÅ ÃÎÂÎĞÈÒÜ ============");
    }
    
    if (questionAccepted(oneMutation)) { 
      console.log("============ ÂÎÏĞÎÑ ÏĞÈÍßÒ ============="); 
    }
    
    if (questionMissed(oneMutation)) { 
      console.log("============ ÂÎÏĞÎÑ ÎÒÑÓÒÑÒÂÓÅÒ ============="); 
    }
  });

});

$(document).ready(function(){
  console.log("ÄÎÊÓÌÅÍÒ ÇÀÃĞÓÆÅÍ");
  observer.observe(document.body,{childList: true, subtree: true, attributes: true, characterData: false});
  //activateVoiceSearch();
  playAudio('http://127.0.0.1/what-you-want-to-find.mp3', activateVoiceSearch);
});

function activateVoiceSearch(){
  $('DIV.input__voice-search').trigger('click');
}

// Àğãóìåíò - îáúåêò "Mutation" èç MutationObserver.
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

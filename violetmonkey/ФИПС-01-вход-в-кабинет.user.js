// ==UserScript==
// @name ФИПС-01-вход-в-кабинет
// @namespace Violentmonkey Scripts
// @include /^https://kpsrtz\.fips\.ru/User/Login$/
// @grant none
// @inject-into content
// @require    https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require	   https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// ==/UserScript==


var $ = window.jQuery;

var observer = new MutationObserver(function(mutations) {
	//console.log('Число изменений: '+mutations.length);

  mutations.forEach(function(oneMutation){
    //console.log(oneMutation.target.className);
    //console.log(oneMutation);
    window.setTimeout(function(){
        
        if (certificateIsLoaded(oneMutation)) {
              console.log("Страница готова к продолжению работы");
            
              playAudio("http://127.0.0.1/fips-arm-registrator-login-page.mp3");

              $("#LoginBtn").click();
          }
        
    }, 1000);

  });

});


observer.observe(document.body, {childList: true, subtree: true, attributes: true, characterData: false});

// Функции
function certificateIsLoaded(mutationObject) {
    return "ФИО: Бунин Владимир Иванович" == mutationObject.target.innerText.trim();
}
// ==UserScript==
// @name     Youtube (результаты поиска с прокруткой)
// @version  1
// @grant    none
// @include  https://www.youtube.com/results?search_query=*
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// @require			 https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/play_audio.js
// @require			 https://github.com/aakumykov/internet_for_blinds/raw/master/greasemonkey/lib/html_functions.js
// ==/UserScript==

var $ = window.jQuery;

let scrollCallbackCounter = 0;


// Запуск скрипта
$(window).load(function() {

  document.title = 'Результаты поиска видео';
  //$(document).prop('title', 'Результаты поиска видео');
  
  $("html, body").animate({ scrollTop: $(document).height()*3 }, 5000, 'swing', function(){
  	let resSet = $("A#video-title");
    scrollCallbackCounter += 1;
    
    if (2==scrollCallbackCounter) {
    	processPage();
    }
  });
  
});


// Функции
function processPage() {
  
  // Слова поискового запроса
  // let searchQuery = $('input#masthead-search-term').attr('value').trim();
  let searchQuery = $('input#search').get(0).value;
 
  // Собираю ссылки на результаты
  let resSet = $("A#video-title");
   
  // Переделываю страницу
	clearPage("результатов поиска видео");

  $(document.body).append("<style>BODY { padding: 20pt; } * { font-family: serif; } A { font-size: 2em; } H1 { text-align:center; padding-bottom: 20pt; }</style>");
  $(document.body).append("<ul id='resultsList'></ul>");

  resSet.each(function(index, element){
    let text = $(element).text();
    let href = "https://www.youtube.com" + $(element).attr('href');
    //$(document.body).append( $("<li><a href='"+href+"' target='_blank'>"+text+"</a></li>") );
    $("ul#resultsList").append( $("<li class='resultsItem'><a href='"+href+"' target='_blank'>"+text+"</a></li>") );
  });

  
  playAudio('http://127.0.0.1/video_search_complete.mp3');
  
  document.title = "поиск видео: «" + searchQuery + "»";
}



// ==UserScript==
// @name     Яндекс.Поиск (видео)
// @version  1
// @grant    none
// @inject-into content
// @include  /^https://yandex\.ru/search/\?/
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// ==/UserScript==

var $ = window.jQuery;


let searchQuery = $("input.input__control").attr('value').trim();

if ("" == searchQuery) {
    // !сказать, что запрос пустой
    return;
}

if (searchQuery.toLowerCase().match("видео")) {
    location.href = "https://www.youtube.com/results?search_query="+searchQuery;
}
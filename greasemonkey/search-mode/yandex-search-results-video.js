// ==UserScript==
// @name     Поиск видео
// @version  1
// @grant    none
// @include  https://yandex.ru/search/*
// @require  https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js
// ==/UserScript==



// Системная настройка JQuery

var $ = window.jQuery;



$(document).ready(function(){

  let searchQuery = $("input.input__control").attr('value').trim();

  if ("" == searchQuery) {
    // !сказать, что запрос пустой
    return;
  }

  //alert(searchQuery) 
  
  if (searchQuery.toLowerCase().match("видео")) {
    //alert("видео");
  	location.href = "https://www.youtube.com/results?search_query="+searchQuery;
  }

});
 
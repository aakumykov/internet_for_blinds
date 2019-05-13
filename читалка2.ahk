#Include, config.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk


isSearchMode() {
	focusFirefox()
	return searchImage("browser\search-mode-ya.ru-dark.bmp", 160, 40, 280, 74, true)
}

isTextSearchResultsMode() {
	focusFirefox()
	return searchImage("browser\search-mode-results-dark.bmp", 150, 30, 520, 90, true)
	
	; return searchImage("browser\youtube-bookmark-icon.bmp", 130, 60, 180, 100, true)
}


F1::
if (isSearchMode()) {
	MsgBox "SEARCH MODE"
} else {
	MsgBox "OTHER MODE"
}
return


F2::
if (isTextSearchResultsMode()) {
	MsgBox "SEARCH RESULTS MODE"
} else {
	MsgBox "OTHER MODE"
}
return
#Include, config.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk


isSearchMode() {
	focusFirefox()
	return searchImage2("browser\search-mode-ya.ru-dark.bmp", 160, 40, 280, 74, false)
}


F1::
if (isSearchMode()) {
	MsgBox "SEARCH MODE"
} else {
	MsgBox "OTHER MODE"
}
return

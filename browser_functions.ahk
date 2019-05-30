#Include, image_functions.ahk


address_bar_x1 := 135
address_bar_y1 := 35
address_bar_x2 := 520
address_bar_y2 := 70


focusFirefox() {
	WinActivate, ahk_class MozillaWindowClass
	;WinMaximize, A // Вызывает задержку. Да и активация окна её вызывает...
}

search_image_in_address_bar(imageFileName, isRelativeToWindow) {
	global address_bar_x1
	global address_bar_y1
	global address_bar_x2
	global address_bar_y2

	return searchImage(imageFileName, address_bar_x1, address_bar_y1, address_bar_x2, address_bar_y2, isRelativeToWindow)
}
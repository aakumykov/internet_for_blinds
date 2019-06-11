
focusFirefox() {
	WinActivate, ahk_class MozillaWindowClass
}

searchImageInAddressBar(imageFileName, isRelativeToWindow) {
	global address_bar_x1
	global address_bar_y1
	global address_bar_x2
	global address_bar_y2
	return searchImage(imageFileName, address_bar_x1, address_bar_y1, address_bar_x2, address_bar_y2, isRelativeToWindow)
}

openLink(){
	; global tab_open_delay

	focusFirefox()
	stopNVDA()

	Send, {Return}
	; Sleep, %tab_open_delay%

	; while (!pageIsLoaded()) {
	; 	Sleep, 100
	; }
	; readPage()
}
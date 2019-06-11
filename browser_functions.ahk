
firefoxIsOpened() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}

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

pageIsLoaded() {
	page_is_loaded_image_pattern := A_ScriptDir . "\images\browser\firefox-page-load-complete.bmp"

	if (firefoxIsOpened()) {
		focusFirefox()
		ImageSearch, imageX, imageY, 76, 47, 100, 72, %page_is_loaded_image_pattern%
		return (imageX and imageY)
	} else {
		;pronounceError "Фаерфокс не запущен!"
		return false
	}
}

openLink(){
	; global text_reader_mode_delay

	focusFirefox()
	stopNVDA()

	Send, {Return}
	; Sleep, %text_reader_mode_delay%

	while (!pageIsLoaded()) {
		Sleep, 100
	}
	readPage()
}

readPage() {
	enableTextReaderMode()
	while (!is_text_reader_mode()) {
		Sleep, 100
	}
	textPlayPause()
}
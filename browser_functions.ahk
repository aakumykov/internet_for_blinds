
firefoxIsOpened() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}

focusFirefox() {
	WinActivate, ahk_class MozillaWindowClass
}

closeBrowserPage() {
	global browser_is_closed_check_delay

	if (firefoxIsOpened()) {
		focusFirefox()
		Send, ^w
		muteNVDA()
		playSound("page-closed.mp3")
	}
}

searchImageInAddressBar(imageFileName, isRelativeToWindow) {
	global address_bar_x1
	global address_bar_y1
	global address_bar_x2
	global address_bar_y2
	return searchImage(imageFileName, address_bar_x1, address_bar_y1, address_bar_x2, address_bar_y2, isRelativeToWindow)
}



openLinkAndRead() {
	openLink()

	if (is_redline_video_mode()) {
		redlineVideoPlayPause()
	}
	else if (is_redline_text_mode()) {
		readPage()
	}
}

openMailMessageLink() {
	openLink()
	readMailMessage()
}

openLink(){
	global tab_open_delay

	focusFirefox()
	muteNVDA()

	Send, {Return}
	Sleep, %tab_open_delay%

	while (!pageIsLoaded()) {
		Sleep, 100
	}
}

readPage() {
	enableTextReaderMode()
	while (!is_text_reader_mode()) {
		Sleep, 100
	}
	textPlayPause()
}

readMailMessage() {
	startNVDA(true)
	Click, 31, 133
	Send, ^a
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

copyPageAddress() {
	focusFirefox()
	Send, ^{l}
	Send, ^{c}
}

testClipboardWithRegex(regex){
	return RegExMatch(clipboard, regex)
}
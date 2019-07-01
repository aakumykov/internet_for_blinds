
firefoxIsOpened() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}

focusFirefox() {
	WinActivate, ahk_class MozillaWindowClass
}

openLinkAndWaitPageIsLoaded() {
	global tab_open_delay
	global page_load_wait_time

	focusFirefox()
	muteNVDA()

	Send, {Return}
	Sleep, %tab_open_delay%

	waitForEventDuringSeconds("pageIsLoaded", page_load_wait_time)
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

pageNotLoaded() {
	return !pageIsLoaded()
}

closeBrowserPage(silent) {
	global browser_is_closed_check_delay

	if (firefoxIsOpened()) {
		focusFirefox()
		Send, ^w
		muteNVDA()
		if (!silent) {
			playSound("page-closed.mp3")
		}
	}
}

searchImageInAddressBar(imageFileName, isRelativeToWindow) {
	global address_bar_x1
	global address_bar_y1
	global address_bar_x2
	global address_bar_y2
	return searchImage(imageFileName, address_bar_x1, address_bar_y1, address_bar_x2, address_bar_y2, isRelativeToWindow)
}

copyPageAddress() {
	focusFirefox()
	Send, ^{l}
	Send, ^{c}
}


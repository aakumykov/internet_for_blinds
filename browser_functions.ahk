
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

	; Не нужно, мешается
	; playSound("page-opened.mp3")
}

pageIsLoaded() {
	global firefox_page_is_loaded_image
	global firefox_page_is_loaded_x1
	global firefox_page_is_loaded_y1
	global firefox_page_is_loaded_x2
	global firefox_page_is_loaded_y2

	page_is_loaded_image_pattern := A_ScriptDir . "\images\browser\" . firefox_page_is_loaded_image

	if (firefoxIsOpened()) {
		focusFirefox()
		ImageSearch, imageX, imageY, firefox_page_is_loaded_x1, firefox_page_is_loaded_y1, firefox_page_is_loaded_x2, firefox_page_is_loaded_y2, %page_is_loaded_image_pattern%
		if (2 == ErrorLevel) {
			Throw, "CANNOT PRODUCE IMAGESEARCH"
		}
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


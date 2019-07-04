
firefoxIsOpened() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}

focusFirefox() {
	WinActivate, ahk_class MozillaWindowClass
}

openLinkAndWaitPageIsLoaded() {
	global tab_creation_delay
	global page_load_wait_time

	focusFirefox()
	muteNVDA()

	Send, {Return}
	Sleep, %tab_creation_delay%

	waitForEventDuringSeconds("pageIsLoaded", page_load_wait_time)

	; Не нужно, мешается
	; playSound("page-opened.mp3")
}

pageIsLoaded() {
	global page_is_loaded_search_area_image_pattern
	global page_is_loaded_search_area_x1
	global page_is_loaded_search_area_y1
	global page_is_loaded_search_area_x2
	global page_is_loaded_search_area_y2

	page_is_loaded_search_area_image_pattern := A_ScriptDir . "\images\browser\" . page_is_loaded_search_area_image_pattern

	if (firefoxIsOpened()) {
		focusFirefox()
		ImageSearch, imageX, imageY, page_is_loaded_search_area_x1, page_is_loaded_search_area_y1, page_is_loaded_search_area_x2, page_is_loaded_search_area_y2, %page_is_loaded_search_area_image_pattern%
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

; address_bar_x1 := 130
; address_bar_y1 := 30
; address_bar_x2 := 600
; address_bar_y2 := 75

; searchImageInAddressBar(imageFileName, isRelativeToWindow) {
; 	global address_bar_x1
; 	global address_bar_y1
; 	global address_bar_x2
; 	global address_bar_y2
; 	return searchImage(imageFileName, address_bar_x1, address_bar_y1, address_bar_x2, address_bar_y2, isRelativeToWindow)
; }

copyPageAddress() {
	focusFirefox()
	Send, ^{l}
	Send, ^{c}
	; Send, {Tab}
	; Send, {Tab}
	; Send, {Tab}
}


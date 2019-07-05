should_wait_for_page_loading := true


firefoxIsOpened() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}

focusFirefox() {
	WinActivate, ahk_class MozillaWindowClass
	; WinMaximize, ahk_class MozillaWindowClass
}

openLink_And_WaitForLoad() {
	global tab_creation_delay
	global page_load_wait_time
	global should_wait_for_page_loading

	; Открываю страницу
	focusFirefox()
	muteNVDA()

	Send, {Return}
	Sleep, %tab_creation_delay%

	; Жду её загрузки
	should_wait_for_page_loading := true

	passed_time := 0
	sleep_step := 100

	while (passed_time < page_load_wait_time) {

		if (pageIsLoaded()) {
			return
		}

		if (!should_wait_for_page_loading) {
			return
		}

		Sleep, sleep_step
		passed_time := passed_time + sleep_step
	}

	playSound("wait-timeout.mp3")
	Sleep, 500
	closePage(false)
}


pageIsLoaded() {
	global page_is_loaded_image_pattern
	global page_is_loaded_search_area_x1
	global page_is_loaded_search_area_y1
	global page_is_loaded_search_area_x2
	global page_is_loaded_search_area_y2

	image_pattern := A_ScriptDir . "\images\browser\" . page_is_loaded_image_pattern

	if (firefoxIsOpened()) {
		focusFirefox()
		ImageSearch, imageX, imageY, page_is_loaded_search_area_x1, page_is_loaded_search_area_y1, page_is_loaded_search_area_x2, page_is_loaded_search_area_y2, %image_pattern%
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

copyPageAddress() {
	focusFirefox()
	Send, ^{l}
	Send, ^{c}
	; Send, {Tab}
	; Send, {Tab}
	; Send, {Tab}
}


is_microphone_active() {
	global active_microphone_image_pattern
	global active_microphone_x1 := 680
	global active_microphone_y1 := 0
	global active_microphone_x2 := 760
	global active_microphone_y2 := 40
	return searchImage(active_microphone_image_pattern, active_microphone_x1, active_microphone_y1, active_microphone_x2, active_microphone_y2, false)
}

openRedLineChannel() {
	startWebServer()
	Run, firefox.exe "https://www.rline.tv", C:\Program Files\Mozilla Firefox\
}

redlineVideoPlayPause() {
	Click, 300, 300
}

; Определение режима списка
; Главная функция определения режима списка
is_redline_list_mode() {
	if (is_redline_main_page()) {
		return true
	}
	if (is_redline_programs_list()) {
		return true
	}
	return false
}

; Функции определения разных видов списка
is_redline_main_page() {
	focusFirefox()
	return searchImageInAddressBar("browser\redline-main-page.bmp", true)
}

is_redline_programs_list() {
	focusFirefox()
	return searchImageInAddressBar("browser\redline-programs-list.bmp", true)
}
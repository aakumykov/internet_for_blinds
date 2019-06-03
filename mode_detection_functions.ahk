
; Определение текущего режима
is_search_start_mode() {
	focusFirefox()
	mode1 := searchImageInAddressBar("browser\search-mode-ya.ru-default.bmp", true)
	mode2 := searchImageInAddressBar("browser\search-mode-ya.ru-light.bmp", true)
	mode3 := searchImageInAddressBar("browser\search-mode-ya.ru-dark.bmp", true)
	return (mode1 or mode2 or mode3)
}

is_list_mode() {
	if (is_text_search_results_mode()) {
		return true
	}
	if (is_mail_list_mode()) {
		return true
	}
	if (is_video_search_results_mode()) {
		return true
	}
	return false
}

is_content_mode() {
	if (is_text_reader_mode()) {
		return true
	}
	if (is_mail_message_mode()) {
		return true
	}
	if (is_youtube_watch_mode()) {
		return true
	}
}


; Виды списка
is_text_search_results_mode() {
	focusFirefox()
	return searchImageInAddressBar("browser\search-mode-results-dark.bmp", true)
}

is_mail_list_mode() {
	focusFirefox()
	
	listMode1 := searchImageInAddressBar("browser\mail-mode-list-default-1.bmp", true)
	listMode2 := searchImageInAddressBar("browser\mail-mode-list-default-2.bmp", true)

	; listMode1 := searchImageInAddressBar("browser\mail-mode-list-light-1.bmp", true)
	; listMode2 := searchImageInAddressBar("browser\mail-mode-list-light-2.bmp", true)

	; listMode1 := searchImageInAddressBar("browser\mail-mode-list-light-1-home.bmp", true)
	; listMode2 := searchImageInAddressBar("browser\mail-mode-list-light-2-home.bmp", true)

	; listMode1 := searchImageInAddressBar("browser\mail-mode-list-dark-1.bmp", true)
	; listMode2 := searchImageInAddressBar("browser\mail-mode-list-dark-2.bmp", true)

	return (listMode1 or listMode2)
}

is_video_search_results_mode() {
	focusFirefox()
	return searchImageInAddressBar("browser\search-mode-video-results-dark.bmp", true)
}


; Виды содержимого
is_text_reader_mode() {
	focusFirefox()
	return searchImage("browser\reader-mode-letter-default-home.bmp", 0, 90, 44, 250, true)
}

is_mail_message_mode(){
	focusFirefox()
	messageMode1 := searchImageInAddressBar("browser\mail-mode-message-light.bmp", true)
	messageMode2 := searchImageInAddressBar("browser\mail-mode-message-dark.bmp", true)
	return (messageMode1 or messageMode2)
}

is_youtube_watch_mode() {
	focusFirefox()
	light := searchImageInAddressBar("browser\youtube-mode-watch-light.bmp", true)
	dark := searchImageInAddressBar("browser\youtube-mode-watch-dark.bmp", true)
	return (light or dark)
}
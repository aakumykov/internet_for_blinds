
; Определение текущего режима
is_search_start_mode() {
	focusFirefox()
	mode1 := searchImage("browser\search-mode-ya.ru-default.bmp", 135, 35, 520, 70, true)
	mode2 := searchImage("browser\search-mode-ya.ru-light.bmp", 135, 35, 520, 70, true)
	mode3 := searchImage("browser\search-mode-ya.ru-dark.bmp", 135, 35, 520, 70, true)
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
	return searchImage("browser\search-mode-results-dark.bmp", 138, 30, 520, 90, true)
}

is_mail_list_mode() {
	focusFirefox()
	
	listMode1 := searchImage("browser\mail-mode-list-default-1.bmp", 138, 30, 520, 90, true)
	listMode2 := searchImage("browser\mail-mode-list-default-2.bmp", 138, 30, 520, 90, true)

	; listMode1 := searchImage("browser\mail-mode-list-light-1.bmp", 136, 36, 600, 70, true)
	; listMode2 := searchImage("browser\mail-mode-list-light-2.bmp", 136, 36, 600, 70, true)

	; listMode1 := searchImage("browser\mail-mode-list-light-1-home.bmp", 136, 36, 600, 70, true)
	; listMode2 := searchImage("browser\mail-mode-list-light-2-home.bmp", 136, 36, 600, 70, true)

	; listMode1 := searchImage("browser\mail-mode-list-dark-1.bmp", 136, 36, 600, 70, true)
	; listMode2 := searchImage("browser\mail-mode-list-dark-2.bmp", 136, 36, 600, 70, true)

	return (listMode1 or listMode2)
}

is_video_search_results_mode() {
	focusFirefox()
	return searchImage("browser\search-mode-video-results-dark.bmp", 138, 30, 520, 90, true)
}


; Виды содержимого
is_text_reader_mode() {
	focusFirefox()
	return searchImage("browser\reader-mode-letter.bmp", 0, 90, 44, 250, true)
}

is_mail_message_mode(){
	focusFirefox()
	messageMode1 := searchImage("browser\mail-mode-message-light.bmp", 138, 30, 520, 90, true)
	messageMode2 := searchImage("browser\mail-mode-message-dark.bmp", 138, 30, 520, 90, true)
	return (messageMode1 or messageMode2)
}

is_youtube_watch_mode() {
	focusFirefox()
	light := searchImage("browser\youtube-mode-watch-light.bmp", 138, 30, 520, 90, true)
	dark := searchImage("browser\youtube-mode-watch-dark.bmp", 138, 30, 520, 90, true)
	return (light or dark)
}
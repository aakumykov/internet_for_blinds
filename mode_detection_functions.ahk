
; Определение текущего режима
is_search_start_mode() {
	focusFirefox()
	if (searchImageInAddressBar("browser\search-mode-ya.ru-default.bmp", true)) {
		return true
	}
	if (searchImageInAddressBar("browser\search-mode-ya.ru-light.bmp", true)) {
		return true
	}
	if (searchImageInAddressBar("browser\search-mode-ya.ru-dark.bmp", true)) {
		return true
	}
	return false
}

is_list_mode() {
	if (is_mail_list_mode()) 			{ 
		return true 
	}
	if (is_text_search_results_mode())  { 
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
	return false
}


; Виды списка
is_text_search_results_mode() {
	focusFirefox()

	if (searchImageInAddressBar("browser\search-mode-results-default.bmp", true)) {
		return true
	}

	if (searchImageInAddressBar("browser\search-mode-results-dark.bmp", true)) {
		return true
	}

	; if (searchImageInAddressBar("browser\search-mode-results-lite.bmp", true)) {
	; 	return true
	; }

	; if (searchImageInAddressBar("browser\search-mode-results-dark.bmp", true)) {
	; 	return true
	; }
}

is_mail_list_mode() {
	focusFirefox()
	
	if (searchImageInAddressBar("browser\mail-mode-list-dark-1-work.bmp", true)) { 
		return true 
	}
	if (searchImageInAddressBar("browser\mail-mode-list-dark-2.bmp", true)) { 
		return true 
	}

	if (searchImageInAddressBar("browser\mail-mode-list-default-1.bmp", true)) { 
		return true 
	}
	if (searchImageInAddressBar("browser\mail-mode-list-default-2.bmp", true)) { 
		return true 
	}

	if (searchImageInAddressBar("browser\mail-mode-list-light-1.bmp", true)) { 
		return true 
	}
	if (searchImageInAddressBar("browser\mail-mode-list-light-2.bmp", true)) { 
		return true 
	}

	; if (searchImageInAddressBar("browser\mail-mode-list-light-1-home.bmp", true)) { 
	; 	return true 
	; }
	; if (searchImageInAddressBar("browser\mail-mode-list-light-2-home.bmp", true)) { 
	; 	return true 
	; }

	

	return false
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
	if (searchImageInAddressBar("browser\mail-mode-message-light.bmp", true)) { 
		return true 
	}
	if (searchImageInAddressBar("browser\mail-mode-message-dark.bmp", true)) { 
		return true 
	}
	return false
}

is_youtube_watch_mode() {
	focusFirefox()
	if (searchImageInAddressBar("browser\youtube-mode-watch-default-home.bmp", true)) { 
		return true 
	}
	if (searchImageInAddressBar("browser\youtube-mode-watch-light.bmp", true)) { 
		return true 
	}
	if (searchImageInAddressBar("browser\youtube-mode-watch-dark.bmp", true)) { 
		return true 
	}
	return false
}
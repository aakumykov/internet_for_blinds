
getMode() {
	global WORK_MODE

	if ("undefined" == WORK_MODE) {
		detectMode()
	}
	
	return WORK_MODE
}


detectMode() {
	global WORK_MODE

	copyPageAddress()

	if (is_search_start_mode()) {
		WORK_MODE := "SEARCH_START"
	}
	else if (is_list_mode()) {
		WORK_MODE := "LIST_MODE"
	}
	else if (is_content_mode()) {
		WORK_MODE := "CONTENT_MODE"
	}
}


; Определение текущего режима
is_search_start_mode() {
	return testClipboardWithRegex("^https://ya.ru/?$")
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
	if (is_redline_list_mode()) {
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
	if (is_redline_video_mode()) {
		return true
	}
	return false
}


; Виды списка
is_text_search_results_mode() {
	return testClipboardWithRegex("^https://yandex\.ru/search/\?")
}

is_mail_list_mode() {
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/?$")
}

is_video_search_results_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/results\?search_query=")
}




; Виды содержимого
is_text_reader_mode() {
	return searchImage("browser\reader-mode-letter-default-home.bmp", 0, 90, 44, 250, true)
}

is_mail_message_mode(){
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/message/[^/]+$")
}

is_youtube_watch_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/watch\?")
}



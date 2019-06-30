modeStack := new ModeStack()

getMode() {
	mode := modeStack.getCurrentMode()

	if ("" == mode) {
		detectMode()
	}
	
	return modeStack.getCurrentMode()
}

detectMode() {
	copyPageAddress()

	if (is_redline_video_mode()) {
		modeStack.addRedlineVideoMode()
		return
	}

	if (is_redline_text_mode()) {
		modeStack.addRedlineTextMode()
		return
	}

	if (is_search_start_mode()) {
		modeStack.addMode("SEARCH_START")
		return
	}

	if (is_list_mode()) {
		modeStack.addMode("LIST_MODE")
		return
	}

	if (is_content_mode()) {
		modeStack.addMode("CONTENT_MODE")
		return
	}
}

clearModes() {
	modeStack.clearModes()
}


; Определение текущего режима
is_search_start_mode() {
	return testClipboardWithRegex("^https://ya.ru/?$")
}

is_list_mode() {
	if (is_mail_list_mode()) 			{ 
		return true 
	}
	if (is_mail_message_mode()) { 
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




reportUnknownMode() {
	playSound("unknown-mode.mp3")
}
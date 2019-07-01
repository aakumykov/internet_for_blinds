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
	; TrayTip, "detectMode()", ";-)"

	if (is_redline_video_mode()) {
		modeStack.addRedlineVideoMode()
		return
	}

	if (is_redline_text_mode()) {
		modeStack.addRedlineTextMode()
		return
	}

	if (is_search_start_mode()) {
		modeStack.addSearchMode()
		return
	}

	if (is_list_mode()) {
		modeStack.addListMode()
		return
	}

	if (is_youtube_video_mode()) {
		modeStack.addYoutubeVideoMode()
		return
	}

	if (is_content_mode()) {
		modeStack.addMode("CONTENT_MODE")
		return
	}

	modeStack.addUnknownMode()
	reportUnknownMode()
}

clearModes() {
	modeStack.clearModes()
}


; РћРїСЂРµРґРµР»РµРЅРёРµ С‚РµРєСѓС‰РµРіРѕ СЂРµР¶РёРјР°
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
	if (is_youtube_video_mode()) { 
		return true 
	}
	if (is_redline_video_mode()) {
		return true
	}
	return false
}


; Р’РёРґС‹ СЃРїРёСЃРєР°
is_text_search_results_mode() {
	return testClipboardWithRegex("^https://yandex\.ru/search/\?")
}

is_mail_list_mode() {
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/?$")
}

is_video_search_results_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/results\?search_query=")
}




; Р’РёРґС‹ СЃРѕРґРµСЂР¶РёРјРѕРіРѕ
is_text_reader_mode() {
	return searchImage("browser\reader-mode-letter-default-home.bmp", 0, 90, 44, 250, true)
}

is_mail_message_mode(){
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/message/[^/]+$")
}

is_youtube_video_mode() {
	return testClipboardWitt
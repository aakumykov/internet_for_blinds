eStack := new ModeStack()

getMode() {
	mode := modeStack.getCurrentMode()

	if ("" == mode) {
		detectMode()
	}
	
	return modeStack.getCurrentMode()
}

detectMode() {
	copyPageAddress()

	; Начало поиска
	if (is_search_start_mode()) {
		modeStack.addSearchMode()
		return
	}

	; Список
	if (is_list_mode()) {
		modeStack.addListMode()
		return
	}

	; Видео
	if (is_redline_video_mode()) {
		modeStack.addRedlineVideoMode()
		return
	}

	if (is_youtube_video_mode()) {
		modeStack.addYoutubeVideoMode()
		return
	}

	if (is_text_reader_mode()) {
		modeStack.addReaderMode()
		return
	}

	; Если другие режимы не подходят,
	; принимаем за текстовый
	modeStack.addTextMode()

	cm := this.getCurrentMode()
	TrayTip, "detectMode()", %cm%
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
	if (is_youtube_video_mode()) { 
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
	global reader_mode_image_pattern
	global reader_mode_serch_area_x1
	global reader_mode_serch_area_y1
	global reader_mode_serch_area_x2
	global reader_mode_serch_area_y2

	return searchImage("browser\" . reader_mode_image_pattern, reader_mode_serch_area_x1, reader_mode_serch_area_y1, reader_mode_serch_area_x2, reader_mode_serch_area_y2, true)
}

findImage(pattern_file_name) {
	global images_dir
	global reader_mode_serch_area_x1
	global reader_mode_serch_area_y1
	global reader_mode_serch_area_x2
	global reader_mode_serch_area_y2

	imageFile := images_dir . "\" . pattern_file_name

	ImageSearch, OutputVarX, OutputVarY, reader_mode_serch_area_x1, reader_mode_serch_area_y1, reader_mode_serch_area_x2, reader_mode_serch_area_y2, %imageFile%

	if (2==ErrorLevel) {
		Throw, "CANNOT PRODUCE ImageSearch"
	}

	return 0 == ErrorLevel
}

is_mail_message_mode(){
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/message/[^/]+$")
}

is_youtube_video_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/watch\?")
}




reportUnknownMode() {
	playSound("unknown-mode.mp3")
}
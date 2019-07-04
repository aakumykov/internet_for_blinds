modeStack := new ModeStack()


detectMode() {
	copyPageAddress()

	; Определение режима Чтеца должно производиться
	; первым, так как пересекается с другими режимами.
	if (is_text_reader_mode()) {
		modeStack.addReaderMode()
		return
	}


	; -------- Режим начала поиска ----------
	if (is_search_start_mode()) {
		modeStack.addSearchMode()
		return
	}


	; ---------- Режимы списка ------------
	if (is_mail_list_mode()) { 
		modeStack.addListMode()
		return 
	}
	if (is_mail_message_mode()) { 
		modeStack.addListMode()
		return  
	}
	if (is_text_search_results_mode()) { 
		modeStack.addListMode()
		return  
	}
	if (is_video_search_results_mode()) { 
		modeStack.addListMode()
		return  
	}
	if (is_redline_list_mode()) {
		modeStack.addListMode()
		return 
	}


	; ------------ Режимы просмотра видео ------------
	if (is_redline_video_mode()) {
		modeStack.addRedlineVideoMode()
		return
	}

	if (is_youtube_video_mode()) {
		; youtubeClickAtEmptyPlace()
		modeStack.addYoutubeVideoMode()
		return
	}

	if (is_yandex_video_mode()) {
		modeStack.addYandexVideoMode()
		return
	}


	; ------------ Режим по умолчанию ------------
	modeStack.addTextMode()
}



reportUnknownMode(label) {
	playSound("unknown-mode.mp3")
	TrayTip, reportUnknownMode, %label%, 1
}

reportCannotStepForward() {
	playSound("cannot-step-forward-in-this-mode.mp3")
	showCurrentModeInTray()
}

reportCannotStepBack() {
	playSound("cannot-step-back-in-this-mode.mp3")
	showCurrentModeInTray()
}

reportCannotPlayPause() {
	playSound("cannot-play-pause.mp3")
	showCurrentModeInTray()
}



showCurrentModeInTray() {
	cm := modeStack.getCurrentMode()
	TrayTip, current mode, %cm%, 1
}
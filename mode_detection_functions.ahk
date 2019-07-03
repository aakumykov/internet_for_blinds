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
		modeStack.addYoutubeVideoMode()
		return
	}


	; ------------ Режим по умолчанию ------------
	modeStack.addTextMode()
}



reportUnknownMode() {
	playSound("unknown-mode.mp3")
}

reportCannotStepForward() {
	playSound("cannot-step-forward-in-this-mode.mp3")
}

reportCannotStepBack() {
	playSound("cannot-step-back-in-this-mode.mp3")
}

reportCannotPlayPause() {
	playSound("cannot-play-pause.mp3")
}

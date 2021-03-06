﻿modeStack := new ModeStack()


detectMode() {
	copyPageAddress()

	; ===== НЕЛЬЗЯ!!!===
	; Вызов setReaderMode() здесь ведёт к ошибкам работы в случае отсутствия читабельной версии.
	; ===== НЕЛЬЗЯ!!!===
	; Определение режима Чтеца должно производиться
	; первым, так как пересекается с другими режимами.
	; if (is_text_reader_mode()) {
	; 	modeStack.setReaderMode()
	; 	return
	; }


	; -------- Режим начала поиска ----------
	if (is_search_start_mode()) {
		modeStack.addSearchMode()
		return
	}


	; ---------- Режимы списка ------------
	if (is_mail_list_mode()) { 
		modeStack.addMailListMode()
		return 
	}
	if (is_mail_message_mode()) { 
		; MsgBox "is_mail_message_mode"
		modeStack.addListMode()
		return  
	}
	if (is_text_search_results_mode()) { 
		; MsgBox "is_text_search_results_mode"
		modeStack.addListMode()
		return  
	}
	if (is_video_search_results_mode()) { 
		; MsgBox "is_video_search_results_mode"
		modeStack.addListMode()
		return  
	}
	if (is_redline_list_mode()) {
		; MsgBox "is_redline_list_mode"
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

	if (is_redline_live_mode()) {
		modeStack.addRedlineLiveMode()
		return
	}


	; ------------ Режим по умолчанию ------------
	; MsgBox, , detectMode(), "default TEXT_MODE will be added now"
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
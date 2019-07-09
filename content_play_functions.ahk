
openLinkAndPlay(delayAfterLoad) {
	muteNVDA()

	; MsgBox "before openLink_And_WaitForLoad()"

	openLink_And_WaitForLoad()
	Sleep, delayAfterLoad
	detectMode()

	; cm := modeStack.getCurrentMode()
	; MsgBox, , detectMode(), %cm%, 1
	; return

	if (modeStack.isRedlineVideoMode()) {
		videoPlayPause()
		return
	}

	if (modeStack.isYoutubeVideoMode()) {
		; playSound("video-has-opened.mp3")
		; youtubeVideoPlayPause()
		return
	}

	if (modeStack.isYandexVideoMode()) {
		return
	}

	if (modeStack.isTextMode()) {
		; MsgBox "TEXT MODE"
		enableReaderAndRead()
		return
	}

	; if (modeStack.isMailMessageMode()) {
	; 	return
	; }

	; Этот режим должен стоять последним, как более общий.
	if (modeStack.isListMode()) {
		return
	}

	reportUnknownMode("openLinkAndPlay()")
}


; readMailMessage() {
; 	startNVDA(true)
; 	Click, 31, 133
; 	Send, ^a
; }
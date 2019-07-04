
openLinkAndPlay() {
	muteNVDA()
	openLinkAndWaitPageIsLoaded()

	detectMode()

	; cm := modeStack.getCurrentMode()
	; MsgBox, , Current Mode, %cm%, 1

	if (modeStack.isRedlineVideoMode()) {
		videoPlayPause()
		return
	}

	if (modeStack.isYoutubeVideoMode()) {
		; playSound("video-has-opened.mp3")
		return
	}

	if (modeStack.isYandexVideoMode()) {
		return
	}

	if (modeStack.isTextMode()) {
		enableReaderAndRead()
		return
	}

	if (modeStack.isListMode()) {
		return
	}

	reportUnknownMode("openLinkAndPlay()")
}

readMailMessage() {
	startNVDA(true)
	Click, 31, 133
	Send, ^a
}
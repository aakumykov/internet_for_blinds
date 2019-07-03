
openLinkAndPlay() {
	muteNVDA()
	openLinkAndWaitPageIsLoaded()

	detectMode()

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
		MsgBox "text mode"
		activateReaderAndRead()
		return
	}

	reportUnknownMode("openLinkAndPlay()")
}

readMailMessage() {
	startNVDA(true)
	Click, 31, 133
	Send, ^a
}
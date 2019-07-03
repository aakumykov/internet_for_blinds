
openLinkAndPlay() {
	muteNVDA()
	openLinkAndWaitPageIsLoaded()
	detectMode()

	; cm := modeStack.getCurrentMode()
	; MsgBox current mode: %cm%

	if (modeStack.isYoutubeVideoMode()) {
		videoPlayPause()
		return
	}

	if (modeStack.isRedlineVideoMode()) {
		MsgBox "redline video mode"
		redlineVideoPlayPause()
		return
	}

	if (modeStack.isTextMode()) {
		activateReaderAndRead()
		return
	}

	reportUnknownMode()
}

readMailMessage() {
	startNVDA(true)
	Click, 31, 133
	Send, ^a
}
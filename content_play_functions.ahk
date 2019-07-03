
openLinkAndPlay() {
	muteNVDA()
	openLinkAndWaitPageIsLoaded()
	detectMode()

	; cm := modeStack.getCurrentMode()
	; MsgBox current mode: %cm%

	if (modeStack.isVideoMode()) {
		videoPlayPause()
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
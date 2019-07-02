
openLinkAndPlay() {
	;MsgBox "openLinkAndPlay()"

	muteNVDA()
	; modeStack.addEmptyMode()
	openLinkAndWaitPageIsLoaded()
	detectMode()

	if (modeStack.isYoutubeVideoMode()) {
		videoPlayPause()
		return
	}

	if (modeStack.isRedlineVideoMode()) {
		redlineVideoPlayPause()
		return
	}

	if (modeStack.isTextMode()) {
		enableTextReaderMode()
		detectMode()
		if (modeStack.isReaderMode()) {
			textPlayPause()
		}
		else {
			playSound("no-readable-version.mp3")
			closePage(true)
		}
	}
}

openLinkAndRead() {
	MsgBox "openLinkAndRead() не реализована"
	
	; openLink()

	; if (is_redline_video_mode()) {
	; 	modeStack.addEmptyMode()
	; 	redlineVideoPlayPause()
	; } else {
	; 	readPage()
	; }
	
	; if (is_redline_text_mode()) {
	; 	readPage()
	; 	return
	; }
}


openMailMessageLink() {
	MsgBox "openMailMessageLink() не реализована"
	; modeStack.addListMode()
	; openLink()
	;readMailMessage()
}

readMailMessage() {
	startNVDA(true)
	Click, 31, 133
	Send, ^a
}
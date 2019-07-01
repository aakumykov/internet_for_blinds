
openLinkAndPlay() {
	modeStack.clearCurrentMode()
	muteNVDA()
	openLinkAndWaitPageIsLoaded()
	detectMode()

	if (modeStack.isYoutubeVideoMode()) {
		;MsgBox "youtube video mode"
		videoPlayPause()
		return
	}

	if (modeStack.isRedlineVideoMode()) {
		redlineVideoPlayPause()
		return
	}

	if (modeStack.isTextMode()) {
		enableTextReaderMode()
		textPlayPause()
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
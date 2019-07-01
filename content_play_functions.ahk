
openLinkAndPlay() {
	modeStack.clearCurrentMode()
	muteNVDA()
	openLinkAndWaitPageIsLoaded()
	detectMode()

	;cm := modeStack.getCurrentMode()
	;MsgBox cm: %cm%

	if (modeStack.isYoutubeVideoMode()) {
		youtubevideoPlayPause()
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

youtubevideoPlayPause() {
	videoPlayPause()
}

readMailMessage() {
	startNVDA(true)
	Click, 31, 133
	Send, ^a
}
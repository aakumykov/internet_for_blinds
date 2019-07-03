
openRedLineChannel() {
	modeStack.addRedlineListMode()
	startWebServer()
	Run, firefox.exe "https://www.rline.tv", C:\Program Files\Mozilla Firefox\
	playSound("redline-is-opening.mp3")
}


openRedlineLink() {
	MsgBox "openRedlineLink() не реализована"
	; openLink()
	; detectMode()
	; redlinePlayPause()
}


is_redline_list_mode() {
	MsgBox "is_redline_list_mode()"

	if (testClipboardWithRegex("^https://www\.rline\.tv/?$")) {
		return true
	}

	if (testClipboardWithRegex("^https://www\.rline\.tv/programs/?$")) {
		return true
	}

	; https://www.rline.tv/programs/temy-dnya/
	if (testClipboardWithRegex("^https://www\.rline\.tv/programs/[^/]+/$")) {
		return true
	}

	MsgBox "is_redline_list_mode(), NO MODE COMPLAINT"

	return false
}

is_redline_video_mode() {
	copyPageAddress()
	;MsgBox "is_redline_video_mode()"
	;https://www.rline.tv/programs/tochka-zreniya/video-186742/
	return testClipboardWithRegex("^https://www\.rline\.tv/programs/[^/]+/video-\d+/$")
}

is_redline_text_mode() {
	copyPageAddress()
	return testClipboardWithRegex("^https://www\.rline\.tv/news/[^/]+/$")
}




redlinePlayPause() {
	if (modeStack.isRedlineVideoMode()) {
		redlineVideoPlayPause()
		return
	}

	if (modeStack.isRedlineTextMode()) {
		enableTextReaderMode()
		waitForEventDuringSeconds("is_text_reader_mode", 5000)
		textPlayPause()
		return
	}

	; reportUnknownMode()
}

redlineVideoPlayPause() {
	Click, 500, 500
}

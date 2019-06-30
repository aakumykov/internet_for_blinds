
openRedLineChannel() {
	modeStack.addRedlineListMode()
	startWebServer()
	Run, firefox.exe "https://www.rline.tv", C:\Program Files\Mozilla Firefox\
}


openRedlineLink() {
	openLink()
	detectMode()
	redlinePlayPause()
}


is_redline_list_mode() {
	if (is_redline_main_page()) {
		return true
	}
	if (is_redline_programs_list()) {
		return true
	}
	return false
}

is_redline_video_mode() {
	copyPageAddress()
	return testClipboardWithRegex("^https://www\.rline\.tv/programs/[^/]+/video-\d+/$")
}

is_redline_text_mode() {
	copyPageAddress()
	return testClipboardWithRegex("^https://www\.rline\.tv/news/[^/]+/$")
}





is_redline_main_page() {
	return testClipboardWithRegex("^https://www\.rline\.tv/?$")
}

is_redline_programs_list() {
	return testClipboardWithRegex("^https://www\.rline\.tv/programs/?$")
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

	reportUnknownMode()
}

redlineVideoPlayPause() {
	Click, 300, 300
}

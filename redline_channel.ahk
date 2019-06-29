
openRedLineChannel() {
	startWebServer()
	Run, firefox.exe "https://www.rline.tv", C:\Program Files\Mozilla Firefox\
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
	regex := "^https://www\.rline\.tv/programs/[^/]+/video-\d+/$"
	return RegExMatch(clipboard, regex)
}


is_redline_main_page() {
	regex := "^https://www\.rline\.tv/$"
	return RegExMatch(clipboard, regex)
}

is_redline_programs_list() {
	regex := "^https://www\.rline\.tv/programs/$"
	return RegExMatch(clipboard, regex)
}


redlineVideoPlayPause() {
	Click, 300, 300
}

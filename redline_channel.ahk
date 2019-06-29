
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
	focusFirefox()

	;if (searchImageInAddressBar("browser\redline-video-mode.bmp", true)) { 
	;	return true 
	;}

	Send, ^{l}
	Send, ^{c}
	return RegExMatch(clipboard, "^https://www\.rline\.tv/programs/[^/]+/video-\d+/$")
}


is_redline_main_page() {
	focusFirefox()
	return searchImageInAddressBar("browser\redline-main-page.bmp", true)
}

is_redline_programs_list() {
	focusFirefox()
	return searchImageInAddressBar("browser\redline-programs-list.bmp", true)
}

redlineVideoPlayPause() {
	Click, 300, 300
}

firefoxReadingIsActive := false

activateReaderAndRead() {
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


enableTextReaderMode() {
	global reader_mode_enable_button_x
	global reader_mode_enable_button_y
	Click, %reader_mode_enable_button_x%, %reader_mode_enable_button_y%

	global reader_mode_wait_time
	waitForEventDuringSeconds("is_text_reader_mode", reader_mode_wait_time)
}

disableTextReaderMode() {
	; global reader_mode_enable_button_x
	; global reader_mode_enable_button_y
	; Click, reader_mode_enable_button_x, reader_mode_enable_button_y
}


textSkipForward() {
	clickReadingControls()
	clickReadNextParagraph()
	clickReadingControls()
}

textSkipBack() {
	clickReadingControls()
	clickReadPrevParagraph()
	clickReadingControls()
}

textPlayPause() {
	focusFirefox()
	clickReadingControls()
	clickPlayPause()
	clickReadingControls()

	global firefoxReadingIsActive
	firefoxReadingIsActive := !firefoxReadingIsActive
}



clickReadingControls() {
	Click 22, 227
}

clickReadNextParagraph() {
	Click, 301, 222
}

clickReadPrevParagraph() {
	Click, 102, 222
}

clickPlayPause() {
	Click, 204, 222
}
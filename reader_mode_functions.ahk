firefoxReadingIsActive := false
should_wait_for_reader_mode := true

is_text_reader_mode() {
	global reader_mode_image_pattern
	global reader_mode_serch_area_x1
	global reader_mode_serch_area_y1
	global reader_mode_serch_area_x2
	global reader_mode_serch_area_y2

	return searchImage("browser\" . reader_mode_image_pattern, reader_mode_serch_area_x1, reader_mode_serch_area_y1, reader_mode_serch_area_x2, reader_mode_serch_area_y2, true)
}

enableReaderAndRead() {
	global should_wait_for_reader_mode
	global reader_mode_wait_time

	should_wait_for_reader_mode := true

	clickTextReaderButton()

	passed_time := 0
	sleep_step := 100

	while (passed_time < reader_mode_wait_time) {

		if (is_text_reader_mode()) {
			modeStack.setReaderMode()
			textPlayPause()
			return
		}	
			
		if (!should_wait_for_reader_mode) {
			return
		}

		if (detect_no_readable_vertion()) {
			playSound("no-readable-version.mp3")
			Sleep, 2000
			closePage(false)
			return
		}

		Sleep, sleep_step
		passed_time := passed_time + sleep_step
	}

	playSound("wait-timeout.mp3")
	Sleep, 2000
	closePage(false)
}


activateTextReaderMode() {
	global reader_mode_wait_time
	waitForEventDuringSeconds("is_text_reader_mode", reader_mode_wait_time)
}

clickTextReaderButton() {
	global reader_mode_enable_button_x
	global reader_mode_enable_button_y
	Click, %reader_mode_enable_button_x%, %reader_mode_enable_button_y%
}

disactivateTextReaderMode() {
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
	Click 22, 239
}

clickReadNextParagraph() {
	Click, 301, 239
}

clickReadPrevParagraph() {
	Click, 102, 239
}

clickPlayPause() {
	Click, 204, 239
}



detect_no_readable_vertion() {
	global no_readable_version_image_pattern
	global no_readable_version_x1
	global no_readable_version_y1
	global no_readable_version_x2
	global no_readable_version_y2

	image_pattern := A_ScriptDir . "\images\browser\" . no_readable_version_image_pattern
	; MsgBox %image_pattern%

	if (firefoxIsOpened()) {
		focusFirefox()
		
		; ImageSearch, imageX, imageY, no_readable_version_search_area_x1, no_readable_version_search_area_y1, no_readable_version_search_area_x2, no_readable_version_search_area_y2, %image_pattern%
		
		ImageSearch, imageX, imageY, 500, 200, 930, 250, C:\Users\User\Documents\reader\images\browser\no-readable-vertion-image-pattern.bmp
		
		; MsgBox %ErrorLevel%

		if (2 == ErrorLevel) {
			Throw, "CANNOT PRODUCE IMAGESEARCH"
		}

		return (imageX and imageY)

	}
	else {
		return false
	}
}
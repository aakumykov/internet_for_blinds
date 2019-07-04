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

		Sleep, sleep_step
		passed_time := passed_time + sleep_step
	}

	playSound("no-readable-version.mp3")
	closePage(true)
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

; activateTextReaderMode() {
; 	global reader_mode_enable_button_x
; 	global reader_mode_enable_button_y
	
; 	Click, %reader_mode_enable_button_x%, %reader_mode_enable_button_y%


; 	global waiting_for_reader_mode
; 	global reader_mode_wait_time

; 	passed_time := 0
; 	sleep_step := 100

; 	while (!is_text_reader_mode() && passed_time < reader_mode_wait_time) {
; 		if (!waiting_for_reader_mode) {
; 			return
; 		}
; 		Sleep, sleep_step
; 		passed_time := passed_time + sleep_step
; 	}
; }

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
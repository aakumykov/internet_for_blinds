#Include, config.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk


is_search_start_mode() {
	focusFirefox()
	; return searchImage("browser\search-mode-ya.ru-dark.bmp", 150, 30, 520, 90, true)
	return searchImage("browser\1.bmp", 138, 30, 520, 90, true)
}


is_list_mode() {
	if (is_text_search_results_mode()) {
		return true
	}
	if (is_mail_list_mode()) {
		return true
	}
	if (is_video_search_results_mode()) {
		return true
	}
	return false
}

is_text_search_results_mode() {
	focusFirefox()
	return searchImage("browser\search-mode-results-dark.bmp", 138, 30, 520, 90, true)
	
	; return searchImage("browser\youtube-bookmark-icon.bmp", 130, 60, 180, 100, true)
}

is_mail_list_mode() {
	focusFirefox()
	return searchImage("browser\mail-mode-list-dark.bmp", 138, 30, 520, 90, true)
}

is_video_search_results_mode() {
	focusFirefox()
	return searchImage("browser\search-mode-video-results-dark.bmp", 138, 30, 520, 90, true)
}


is_mail_message_mode(){
	focusFirefox()
	return searchImage("browser\mail-mode-message-dark.bmp", 138, 30, 520, 90, true)
}






F1::
; if (is_search_start_mode()) {
if (is_list_mode()) {
	; MsgBox "SEARCH MODE"
	MsgBox "LIST MODE"
} else {
	MsgBox "OTHER MODE"
}
return


F2::
if (is_mail_message_mode()) {
	MsgBox "MAIL MESSAGE MODE"
} else {
	MsgBox "OTHER MODE"
}
return

F3::
if (is_mail_list_mode()) {
	MsgBox "MAIL LIST MODE"
} else {
	MsgBox "OTHER MODE"
}
return

F4::
if (is_video_search_results_mode()) {
	MsgBox "VIDEO RESULTS MODE"
} else {
	MsgBox "OTHER MODE"
}
return
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
}

is_mail_list_mode() {
	focusFirefox()
	
	; listMode1 := searchImage("browser\mail-mode-list-defailt-1.bmp", 138, 30, 520, 90, true)
	; listMode2 := searchImage("browser\mail-mode-list-default-2.bmp", 138, 30, 520, 90, true)

	listMode1 := searchImage("browser\mail-mode-list-light-1.bmp", 138, 30, 520, 90, true)
	listMode2 := searchImage("browser\mail-mode-list-light-2.bmp", 138, 30, 520, 90, true)

	; listMode1 := searchImage("browser\mail-mode-list1-dark.bmp", 138, 30, 520, 90, true)
	; listMode2 := searchImage("browser\mail-mode-list2-dark.bmp", 138, 30, 520, 90, true)

	return (listMode1 or listMode2)
}

is_video_search_results_mode() {
	focusFirefox()
	return searchImage("browser\search-mode-video-results-dark.bmp", 138, 30, 520, 90, true)
}


is_mail_message_mode(){
	focusFirefox()
	messageMode1 := searchImage("browser\mail-mode-message-light.bmp", 138, 30, 520, 90, true)
	messageMode2 := searchImage("browser\mail-mode-message-dark.bmp", 138, 30, 520, 90, true)
	return (messageMode1 or messageMode2)
}

is_text_reader_mode() {
	focusFirefox()
	return searchImage("browser\reader-mode-letter.bmp", 0, 90, 44, 250, true)
}

is_youtube_watch_mode() {
	focusFirefox()
	light := searchImage("browser\youtube-mode-watch-light.bmp", 138, 30, 520, 90, true)
	dark := searchImage("browser\youtube-mode-watch-dark.bmp", 138, 30, 520, 90, true)
	return (light or dark)
}





F1::
; if (is_search_start_mode()) {
; if (is_list_mode()) {
; if (is_text_reader_mode()) {
if (is_youtube_watch_mode()) {
	; MsgBox "SEARCH MODE"
	; MsgBox "LIST MODE"
	; MsgBox "TEXT READER MODE"
	MsgBox "YOUTUBE WATCH MODE"
} else {
	MsgBox "OTHER MODE"
}
return


F2::
if (is_mail_list_mode()) {
	MsgBox "MAIL LIST MODE"
} else {
	MsgBox "OTHER MODE"
}
return


F3::
if (is_mail_message_mode()) {
	MsgBox "MAIL MESSAGE MODE"
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
#Include, config_system.ahk
#Include, config_user.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk
#Include, mode_detection_functions.ahk
#Include, list_mode_functions.ahk
#Include, reader_mode_functions.ahk


stepBack() {
	if (is_list_mode()) {
		prevLink()
	}
	else if (is_text_reader_mode()) {
		textSkipBack()
	}
}

stepForward() {
	if (is_list_mode()) {
		nextLink()
	}
	else if (is_text_reader_mode()) {
		textSkipForward()
	}
}







F1::
if (is_list_mode()) {
	MsgBox "LIST MODE"
}
else if (is_content_mode()) {
	MsgBox "CONTENT MODE"
}
else if (is_search_start_mode()) {
	MsgBox "SEARCH START MODE"	
}
else {
	MsgBox "OTHER MODE"
}
return


F2::
; if (is_mail_list_mode()) {
; if (searchImageInAddressBar("browser\search-mode-ya.ru-dark.bmp", true)) {
if (is_text_reader_mode()) {
	; MsgBox "MAIL LIST MODE"
	; MsgBox "SEARCH START MODE"
	MsgBox "TEXT READER MODE"
} else {
	; MsgBox "NOT MAIL LIST MODE"
	; MsgBox "NOT SEARCH START MODE"
	MsgBox "NOT TEXT READER MODE"
}
return

w::
stepBack()
return

x::
stepForward()
return
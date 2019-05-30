#Include, config.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk
#Include, mode_detection_functions.ahk





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
if (search_image_in_address_bar("browser\search-mode-ya.ru-dark.bmp", true)) {
	; MsgBox "MAIL LIST MODE"
	MsgBox "SEARCH START MODE"
} else {
	; MsgBox "NOT MAIL LIST MODE"
	MsgBox "NOT SEARCH START MODE"
}
return

; w:
; step_up()
; return

; ~x:
; step_down()
; return
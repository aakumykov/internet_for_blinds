#Include, config_system.ahk
#Include, config_user.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk
#Include, mode_detection_functions.ahk
#Include, list_mode_functions.ahk
#Include, reader_mode_functions.ahk
#Include, video_mode_functions.ahk
#Include, nvda_functions.ahk



playPause() {
	if (is_list_mode()) {
		openLink()
	}
	else if (is_text_reader_mode()) {
		textPlayPause()
	}
	else if (is_youtube_watch_mode()) {
		videoPlayPause()
	}
}

stepForward() {
	startNVDA()

	if (is_list_mode()) {
		nextLink()
	}
	else if (is_text_reader_mode()) {
		textSkipForward()
	}
	else if (is_youtube_watch_mode()) {
		videoSkipForward()
	}
}

stepBack() {
	startNVDA()

	if (is_list_mode()) {
		prevLink()
	}
	else if (is_text_reader_mode()) {
		textSkipBack()
	}
	else if (is_youtube_watch_mode()) {
		videoSkipBack()
	}
}





openSearch() {
	Run, firefox.exe "http://ya.ru", C:\Program Files\Mozilla Firefox\
}

openMail() {
	Run, firefox.exe "http://mail.yandex.ru/lite", C:\Program Files\Mozilla Firefox\
}


Numpad3::
openMail()
return

Numpad9::
openSearch()
return



F8::
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


F7::
; if (is_mail_list_mode()) {
if (is_list_mode()) {
; if (searchImageInAddressBar("browser\search-mode-ya.ru-dark.bmp", true)) {
; if (is_text_reader_mode()) {
; if (searchImageInAddressBar("browser\youtube-mode-watch-dark-work.bmp", true)) {
; CoordMode, Pixel, Window
; CoordMode, Pixel, Screen

; if (ImageSearch, OutputVarX, OutputVarY, 136, 36, 600, 69, "C:\Users\SANDRA\Documents\internet_for_blinds\images\browser\youtube-mode-watch-dark-work.bmp") {
	; MsgBox "MAIL LIST MODE"
	MsgBox "LIST MODE"
	; MsgBox "SEARCH START MODE"
	; MsgBox "TEXT READER MODE"
	; MsgBox "VIDEO MODE"
} else {
	; MsgBox "NOT MAIL LIST MODE"
	MsgBox "NOT LIST MODE"
	; MsgBox "NOT SEARCH START MODE"
	; MsgBox "NOT TEXT READER MODE"
	; MsgBox "NOT VIDEO MODE"
}
return


F1::
stepForward()
return

F2::
stepBack()
return

F3::
playPause()
return



F9::
Run, nvda.exe, "C:\Program Files (x86)\NVDA", UseErrorLevel
return

F10::
Run, nvda.exe -q, "C:\Program Files (x86)\NVDA", UseErrorLevel
return

F11::

return
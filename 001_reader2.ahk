#Include, config_system.ahk
#Include, config_user.ahk
#Include, image_functions.ahk
#Include, browser_functions.ahk
#Include, mode_detection_functions.ahk
#Include, list_mode_functions.ahk
#Include, reader_mode_functions.ahk
#Include, video_mode_functions.ahk
#Include, nvda_functions.ahk


Numpad3::
openMail()
return

Numpad9::
openSearch()
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

F4::
closePage()
return




playPause() {
	if (is_text_reader_mode()) {
		textPlayPause()
	}
	else if (is_mail_list_mode()) {
		openMailMessageLink()
	}
	else if (is_list_mode()) {
		openRegularLink()
	}
	else if (is_youtube_watch_mode()) {
		videoPlayPause()
	}
}

stepForward() {
	if (is_text_reader_mode()) {
		textSkipForward()
	}
	else if (is_list_mode()) {
		startNVDA()
		nextLink()
	}
	else if (is_youtube_watch_mode()) {
		videoSkipForward()
	}
}

stepBack() {
	if (is_text_reader_mode()) {
		textSkipBack()
	}
	else if (is_list_mode()) {
		startNVDA()
		prevLink()
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
if (is_mail_list_mode()) {
	MsgBox "mail_list_mode"
} else {
	MsgBox "no_mail_list_mode"
}
return

F9::
openLink()
return

F10::
return

F11::
return
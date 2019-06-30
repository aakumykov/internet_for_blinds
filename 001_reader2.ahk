#Include, config_system.ahk
#Include, mode_stack.ahk
#Include, config_user.ahk
#Include, image_functions.ahk
#Include, sound_file_functions.ahk
#Include, browser_functions.ahk
#Include, webserver_functions.ahk
#Include, mode_detection_functions.ahk
#Include, list_mode_functions.ahk
#Include, reader_mode_functions.ahk
#Include, video_mode_functions.ahk
#Include, nvda_functions.ahk
#Include, redline_channel.ahk


Numpad3::
openMail()
return

Numpad6::
openRedLineChannel()
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
	if (is_list_mode()) {
		openLinkAndRead()
	}
	else if (is_mail_list_mode()) {
		openMailMessageLink()
	}
	else if (is_text_reader_mode()) {
		textPlayPause()
	}
	else if (is_youtube_watch_mode()) {
		videoPlayPause()
	}
	else if (is_redline_video_mode()) {
		redlineVideoPlayPause()
	}
	else if (is_redline_text_mode()) {
		
	}
}

stepForward() {
	mode := getMode()

	if (is_text_reader_mode()) {
		textSkipForward()
	}
	else if (is_list_mode()) {
		startNVDA(false)
		unmuteNVDA()
		nextLink()
	}
	else if (is_youtube_watch_mode()) {
		videoSkipForward()
	}
	else if (is_redline_video_mode()) {
		videoSkipForward()
	}
}

stepBack() {
	mode := getMode()

	if (is_text_reader_mode()) {
		textSkipBack()
	}
	else if (is_list_mode()) {
		startNVDA(false)
		unmuteNVDA()
		prevLink()
	}
	else if (is_youtube_watch_mode()) {
		videoSkipBack()
	}
	else if (is_redline_video_mode()) {
		videoSkipBack()
	}
}

closePage() {
	modeStack.popMode()
	closeBrowserPage()
}



openSearch() {
	modeStack.clear()
	startWebServer()
	Run, firefox.exe "http://ya.ru", C:\Program Files\Mozilla Firefox\
}

openMail() {
	modeStack.clear()
	startWebServer()
	Run, firefox.exe "http://mail.yandex.ru/lite", C:\Program Files\Mozilla Firefox\
}












F8::
mode := getMode()
MsgBox, , "CURRENT MODE", %mode%, 1
return

F7::
if (is_mail_list_mode()) {
	MsgBox "mail_list_mode"
} else {
	MsgBox "no_mail_list_mode"
}
return

F9::
detectMode()

if (is_youtube_watch_mode()) {
	TrayTip, "MODE", "is_youtube_watch_mode"
} else {
	TrayTip, "MODE", "NOT is_youtube_watch_mode"
}
return


F10::
muteNVDA()
return

F11::
unmuteNVDA()
return

F12::
if (is_redline_video_mode()) {
	MsgBox "redline_video_mode"
} else {
	MsgBox "NOT redline_video_mode"
}
return


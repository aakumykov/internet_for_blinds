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
	focusFirefox()

	if (modeStack.isRedlineListMode()) {
		openRedlineLink()
		return
	}

	if (modeStack.isRedlineVideoMode()) {
		redlineVideoPlayPause()
		return
	}

	if (modeStack.isMailListMode()) {
		openMailMessageLink()
		return
	}
	
	if (modeStack.isListMode()) {
		openLinkAndRead()
		return
	}
	
	if (is_text_reader_mode()) {
		textPlayPause()
		return
	}

	if (is_youtube_watch_mode()) {
		videoPlayPause()
		return
	}

	if (is_redline_video_mode()) {
		redlineVideoPlayPause()
		return
	}

	reportUnknownMode()
}

stepForward() {
	focusFirefox()

	if (modeStack.isRedlineVideoMode()) {
		videoSkipForward()
		return
	}

	if (modeStack.isListMode()) {
		startNVDA(false)
		unmuteNVDA()
		nextLink()
		return
	}

	if (is_youtube_watch_mode()) {
		videoSkipForward()
		return
	}

	if (is_redline_video_mode()) {
		videoSkipForward()
		return
	}
	
	if (is_text_reader_mode()) { ; Эта функция самая медленная, должна стоять в конце.
		textSkipForward()
		return
	}
}

stepBack() {
	focusFirefox()

	if (modeStack.isRedlineVideoMode()) {
		videoSkipBack()
		return
	}

	if (modeStack.isListMode()) {
		startNVDA(false)
		unmuteNVDA()
		prevLink()
		return
	}
	
	if (is_youtube_watch_mode()) {
		videoSkipBack()
		return
	}

	if (is_redline_video_mode()) {
		videoSkipBack()
		return
	}
	
	if (is_text_reader_mode()) { ; Эта функция самая медленная, должна стоять в конце.
		textSkipBack()
		return
	}
}

closePage() {
	focusFirefox()
	modeStack.popMode()
	closeBrowserPage()
}



openSearch() {
	modeStack.addSearchMode()
	startWebServer()
	Run, firefox.exe "http://ya.ru", C:\Program Files\Mozilla Firefox\
	playSound("search-is-opening.mp3")
}

openMail() {
	modeStack.addMailListMode()
	startWebServer()
	Run, firefox.exe "http://mail.yandex.ru/lite", C:\Program Files\Mozilla Firefox\
	playSound("mail-is-opening.mp3")
}












F8::
mode := getMode()
TrayTip, "CURRENT MODE", %mode%, 1
return

F7::
detectMode()
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

~F11::
unmuteNVDA()
return

; qwerty(soundFile) {
; 	global playerCmd
; 	Run, "c:\Program Files\mpg123\mpg123.exe" %soundFile%, , Hide
;}

~F12::
;playSound("cold-start.mp3")
;Run, mpg123.exe "C:\Users\SANDRA\Documents\internet_for_blinds\sounds\ru\cold-start.mp3", "C:\Program Files\mpg123"
;qwerty("c:\Users\SANDRA\Documents\internet_for_blinds\sounds\ru\cold-start.mp3")
playSound("cold-start.mp3")
return


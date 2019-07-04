#Include, 002_config_user.ahk
#Include, 003_config_system.ahk
#Include, log_functions.ahk
#Include, utility_functions.ahk
#Include, mode_stack.ahk
#Include, image_functions.ahk
#Include, sound_file_functions.ahk
#Include, browser_functions.ahk
#Include, webserver_functions.ahk
#Include, mode_detection_functions.ahk
#Include, list_mode_functions.ahk
#Include, reader_mode_functions.ahk
#Include, video_mode_functions.ahk
#Include, youtube_functions.ahk
#Include, nvda_functions.ahk
#Include, redline_channel_functions.ahk
#Include, yandex_functions.ahk
#Include, content_play_functions.ahk


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
closePage(false)
return




stepForward() {
	focusFirefox()

	if (modeStack.isListMode()) {
		startNVDA(false)
		unmuteNVDA()
		nextLink()
		return
	}

	if (modeStack.isVideoMode()) {
		videoSkipForward()
		return
	}

	if (modeStack.isReaderMode()) {
		textSkipForward()
		return
	}

	reportCannotStepForward()
}

stepBack() {
	focusFirefox()

	if (modeStack.isListMode()) {
		startNVDA(false)
		unmuteNVDA()
		prevLink()
		return
	}

	if (modeStack.isVideoMode()) {
		videoSkipBack()
		return
	}

	if (modeStack.isReaderMode()) {
		textSkipBack()
		return
	}

	reportCannotStepBack()
}

playPause() {
	focusFirefox()

	if (modeStack.isReaderMode()) {
		textPlayPause()
		return
	}

	if (modeStack.isListMode()) {
		openLinkAndPlay()
		return
	}

	if (modeStack.isVideoMode()) {
		; MsgBox,,, "playPause(), video mode", 1
		videoPlayPause()
		return
	}

	if (modeStack.isTextMode()) {
		enableReaderAndRead()
		return
	}

	reportCannotPlayPause()
}

closePage(silent) {
	global should_wait_for_page_loading
	global should_wait_for_reader_mode

	should_wait_for_page_loading := false
	should_wait_for_reader_mode := false

	focusFirefox()

	modeStack.popMode()

	closeBrowserPage(silent)
}



openSearch() {
	muteNVDA()
	modeStack.addSearchMode()
	startWebServer()
	Run, firefox.exe "http://ya.ru", C:\Program Files\Mozilla Firefox\
	playSound("search-is-opening.mp3")
}

openMail() {
	muteNVDA()
	modeStack.addMailListMode()
	startWebServer()
	Run, firefox.exe "http://mail.yandex.ru/lite", C:\Program Files\Mozilla Firefox\
	playSound("mailbox-is-opening.mp3")
}












F7::
if (pageIsLoaded()) {
	MsgBox "page is loaded"
}
else {
	MsgBox "page is not loaded"
}
return

F8::
detectMode()
mode := modeStack.getCurrentMode()
MsgBox,, DETECTED MODE, %mode%
return

F9::
; mode := modeStack.getCurrentMode()
; MsgBox,, CURRENT MODE, %mode%
enableReaderAndRead()
return

F10::
muteNVDA()
return

~F11::
unmuteNVDA()
return

F12::
if (is_text_reader_mode()) {
	MsgBox "text_reader_mode"
}
else {
	MsgBox "not text_reader_mode"
}
return

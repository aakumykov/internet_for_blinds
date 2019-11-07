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

SetNumLockState, On


Numpad3::
openMail()
return

Numpad6::
; openRedLineChannel()
openRedlineLive()
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
	; Run, firefox.exe "http://ya.ru", C:\Program Files\Mozilla Firefox\
	Run, FirefoxPortable.exe "http://ya.ru", %A_ScriptDir%\..\FirefoxPortable
	playSound("search-is-opening.mp3")
	Sleep, 2000
	focusFirefox()
}

openMail() {
	muteNVDA()
	modeStack.addMailListMode()
	startWebServer()
	; Run, firefox.exe "http://mail.yandex.ru/lite", C:\Program Files\Mozilla Firefox\
	Run, FirefoxPortable.exe "http://mail.yandex.ru/lite", %A_ScriptDir%\..\FirefoxPortable
	playSound("mailbox-is-opening.mp3")
}










; F6::
; ; ; MsgBox %A_ScriptDir%\..\FirefoxPortable
; ; Run, FirefoxPortable.exe "http://opennet.ru", %A_ScriptDir%\..\FirefoxPortable
; if ( firefoxIsOpened() ) {
; 	MsgBox "firefox is opened"
; }
; else {
; 	MsgBox "firefox not opened"
; }
; return

F6::
; ImageSearch, OutputVarX, OutputVarY, 86, 46, 127, 85, 1.bmp
; MsgBox %ErrorLevel%

if (pageIsLoaded()) {
; if (is_text_reader_mode()) {
	MsgBox "page is loaded"
; 	MsgBox "text reader mode"
}
else {
	MsgBox "page is not loaded"
; 	MsgBox "not text reader mode"
}

; clickTextReaderButton()
return

; F8::
; detectMode()
; mode := modeStack.getCurrentMode()
; MsgBox,, DETECTED MODE, %mode%
; return

; F9::
; mode := modeStack.getCurrentMode()
; MsgBox,, CURRENT MODE, %mode%
; ; enableReaderAndRead()
; return

; F10::
; copyPageAddress()
; if (is_mail_message_mode()) {
; 	MsgBox "mail message mode"
; } else {
; 	MsgBox "not mail messagemode"
; }
; return

; F11::
; playSound("redline-is-opening.mp3")
; return

; F12::
; ; ImageSearch, imageX, imageY, 500, 200, 930, 250, C:\Users\User\Documents\reader\images\browser\no-readable-vertion-image-pattern.bmp
; ; MsgBox %ErrorLevel%

; ; detect_no_readable_vertion()

; ; if (detect_no_readable_vertion()) {
; ; 	MsgBox "no_readable_vertion"
; ; }
; ; else {
; ; 	MsgBox "NOT no_readable_vertion"
; ; }

; clickReadingControls()
; return

; F12::
; if (is_text_reader_mode()) {
; 	TrayTip, is_text_reader_mode, YES, 1
; }
; else {
; 	TrayTip, is_text_reader_mode, NO, 1
; }
; ; clickReadingControls()
; return

; F9:
; MsgBox, , , "F9", 2
; clickPlayPause()
; TrayTip, "after play pause", 123, 1
; return
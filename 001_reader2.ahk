#Include, config_system.ahk
#Include, config_user.ahk
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
#Include, nvda_functions.ahk
#Include, redline_channel.ahk
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
	}

	if (modeStack.isReaderMode()) {
		textSkipForward()
	}
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
	}

	if (modeStack.isReaderMode()) {
		textSkipBack()
	}
}

playPause() {
	focusFirefox()

	if (modeStack.isListMode()) {
		openLinkAndPlay()
		return
	}

	if (modeStack.isVideoMode()) {
		videoPlayPause()
	}

	if (modeStack.isReaderMode()) {
		textPlayPause()
	}
}

closePage(silent) {
	focusFirefox()

	modeStack.popMode()

	; cm := modeStack.getCurrentMode()
	; MsgBox closePage(), cm: %cm%

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

if (modeStack.isYoutubeVideoMode()) {
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

F12::
;playSound("cold-start.mp3")
;Run, mpg123.exe "C:\Users\SANDRA\Documents\internet_for_blinds\sounds\ru\cold-start.mp3", "C:\Program Files\mpg123"
;qwerty("c:\Users\SANDRA\Documents\internet_for_blinds\sounds\ru\cold-start.mp3")
;playSound("cold-start.mp3")

; if (is_text_reader_mode()) {
; 	MsgBox "is_text_reader_mode"
; } else {
; 	MsgBox "not text_reader_mode"
; }

; if (pageIsLoaded()) {
; 	MsgBox "pageIsLoaded"
; }
; else {
; 	MsgBox "not pageIsLoaded"
; }

CoordMode, Screen
; ImageSearch, OutputVarX, OutputVarY, 0, 164, 38, 202, C:\Users\User\Documents\reader\images\browser\reader-mode-letter-default-home.bmp

image_pattern_file_name := "browser\reader-mode-letter-default-home.bmp"
images_dir := A_ScriptDir . "\" . "images"


; ImageSearch, OutputVarX, OutputVarY, 0, 164, 38, 202, %images_dir%\%image_pattern_file_name%
; if (OutputVarX and OutputVarY) {
if (is_text_reader_mode()) {
; if (findImage("browser\reader-mode-letter-default-home.bmp")) {
; if (searchImage("browser\" . reader_mode_image_pattern, 0, 164, 38, 202, false)) {
	MsgBox "text_reader_mode"
}
else {
	MsgBox "not text_reader_mode"
}

return


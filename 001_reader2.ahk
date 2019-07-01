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

	; Этот режим определяется через груфику,
	; что медленно, должно производиться в конце.
	if (modeStack.isTextMode()) {
		textSkipForward()()
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

	; Этот режим определяется через груфику,
	; что медленно, должно производиться в конце.
	if (modeStack.isTextMode()) {
		textSkipBack()()
	}
}

playPause() {
	focusFirefox()

	openLinkAndPlay()
	return

	if (modeStack.isListMode()) {
		openLinkAndPlay()
		return
	}

	if (modeStack.isVideoMode()) {
		videoPlayPause()
	}

	; Этот режим определяется через груфику,
	; что медленно, должно производиться в конце.
	if (modeStack.isTextMode()) {
		textPlayPause()()
	}
}

closePage() {
	focusFirefox()
	modeStack.popMode()
	closeBrowserPage()
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

~F12::
;playSound("cold-start.mp3")
;Run, mpg123.exe "C:\Users\SANDRA\Documents\internet_for_blinds\sounds\ru\cold-start.mp3", "C:\Program Files\mpg123"
;qwerty("c:\Users\SANDRA\Documents\internet_for_blinds\sounds\ru\cold-start.mp3")
;playSound("cold-start.mp3")
return


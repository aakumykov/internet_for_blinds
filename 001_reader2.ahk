#Include, config_system.ahk
#Include, config_user.ahk
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
	playSound("mailbox-is-opening.mp3")
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


~F12::
LogError(A_LineFile, A_LineNumber, "unknown video mode: " . modeStack.getCurrentMode())

return

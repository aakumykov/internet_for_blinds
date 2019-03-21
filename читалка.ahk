#SingleInstance Force

; Настройки
readerModeIcon_Active := A_ScriptDir . "\images\tray-icons\reader-mode-active.png"
readerModeIcon_Inactive := A_ScriptDir . "\images\tray-icons\reader-mode-inactive.png"
page_is_loaded_image_pattern := A_ScriptDir . "\images\browser\firefox-page-load-complete.bmp"
reader_mode_image_pattern := A_ScriptDir . "\images\browser\firefox-reader-mode-start-icon.png"
video_mode_image_pattern := A_ScriptDir . "\images\browser\youtube.png"
web_server_command := "C:\Program Files (x86)\hfs.exe"
tab_open_delay := 500 ; Важная задержка на то, чтобы дать новой вкладке открыться

; Глобальные переменные
readerModeIsActive := false

isTextMode := false
isVideoMode := false
isMailMode := false

readerModeTimeout := 120
nvdaIsRun := false
firefoxReadingIsActive := false

; Функции
toggleReaderMode() {
	global readerModeIcon_Active
	global readerModeIcon_Inactive
	global readerModeIsActive

	readerModeIsActive := !readerModeIsActive
	if (readerModeIsActive) {
		startWebServer()
		Menu, Tray, Icon, %readerModeIcon_Active%
	} else {
		Menu, Tray, Icon, %readerModeIcon_Inactive%
	}
}

prolongateReaderMode() {
	global readerModeIsActive
	readerModeIsActive := true
}


openTextSearch() {
	global readerModeIsActive
	if (readerModeIsActive) {
		activateTextSearch()
	}
}

openVideoSearch() {
	global readerModeIsActive
	if (readerModeIsActive) {
		activateVideoSearch()
	}
}

openMail(){
	global readerModeIsActive
	if (readerModeIsActive) {
		activateMailMode()
	}
}

activateTextSearch() {
	global isTextMode
	global isVideoMode
	global isMailMode
	isTextMode := true
	isVideoMode := false
	isMailMode := false7
	Run, firefox.exe "http://ya.ru"
	focusFirefox()
}

activateVideoSearch() {
	global isTextMode
	global isVideoMode
	global isMailMode
	isTextMode := false
	isVideoMode := true
	isMailMode := false
}

activateMailMode() {
	global isTextMode
	global isVideoMode
	global isMailMode
	isTextMode := false
	isVideoMode := false
	isMailMode := true
	Run, firefox.exe "http://mail.yandex.ru/lite"
	focusFirefox()7
}



startWebServer() {
	global web_server_command
	;if (! Process, Exist, hfs.exe ) {
		; В настройках HTTPFileServer-а сделано "запускать одну копию",
		; так что можно не проверять (тем более, проверка не работает).
		Run, %web_server_command%, UseErrorLevel
	;}
}


startNVDA() {
	global nvdaIsRun
	;if (! Process, Exist, nvda.exe ) {
	if (!nvdaIsRun) {
		Run, nvda.exe, "C:\Program Files (x86)\NVDA", UseErrorLevel
			;nvdaIsRun := true
	}
}

stopNVDA() {
	global nvdaIsRun
	Process, Close, nvda.exe
	nvdaIsRun := false
}


say(text){
	Run, c:\windows\balcon.exe -n Aleks -t "%text%", ,Hide
}

readClipboard() {
	Run, c:\windows\balcon.exe -n Aleks -c , ,Hide
}

stopReadClipboard() {
	Process, Close, balcon.exe
}

focusFirefox(){
	WinActivate, ahk_class MozillaWindowClass
}

firefoxIsOpened() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}

pageIsLoaded() {
	global page_is_loaded_image_pattern

	if (firefoxIsOpened()) {
		focusFirefox()
		ImageSearch, imageX, imageY, 76, 47, 100, 72, %page_is_loaded_image_pattern%
		return (imageX and imageY)
	} else {
		;pronounceError "Фаерфокс не запущен!"
		return false
	}
}

nextLink(){
	global readerModeIsActive
	if (readerModeIsActive) {
		prolongateReaderMode()
		startNVDA()
		focusFirefox()
		Send, `t
	}
}

prevLink(){
	global readerModeIsActive
	if (readerModeIsActive) {
		prolongateReaderMode()
		startNVDA()
		focusFirefox()
		Send, +`t
	}
}

openLink(){
	global readerModeIsActive
	global tab_open_delay

	if (readerModeIsActive) {
		stopNVDA()
		focusFirefox()
		Send, {Return}
		Sleep, %tab_open_delay%

		while (!pageIsLoaded()) {
			Sleep, 100
		}

		MsgBox "PAGE IS LOADED"
	}
}

closeTab(){
	global readerModeIsActive
	if (readerModeIsActive) {
		focusFirefox()
		Send, {Ctrl down}w{Ctrl up}
	}
	firefoxReadingIsActive := false
	stopReadClipboard()
}


; Работа с режимом чтения Firefox
readerModeIsActiveAvailable() {
	global reader_mode_image_pattern
	ImageSearch, imageX, imageY, 1132, 46, 1158, 73, %reader_mode_image_pattern%
	return (imageX and imageY)
}

readerModeIsActiveActivated() {
	global reader_mode_image_pattern
	ImageSearch, imageX, imageY, 0, 168, 45, 211, %reader_mode_image_pattern%
	return (imageX and imageY)
}

activateReaderView() {
	Click, 1146, 59
}

clickReadingControls() {
	Click 22, 227
}

clickPlayPause() {
	Click, 204, 222
}

clickReadNextParagraph() {
	Click, 301, 222
}

clickReadPrevParagraph() {
	Click, 102, 222
}

startStopReading() {
	global firefoxReadingIsActive
	if (!firefoxReadingIsActive) {
		prolongateReaderMode()
		focusFirefox()
		clickReadingControls()
		clickPlayPause()
		clickReadingControls()
		firefoxReadingIsActive := true
	} else {
		prolongateReaderMode()
		focusFirefox()
		clickReadingControls()
		clickPlayPause()
		clickReadingControls()
		firefoxReadingIsActive := false
	}
}

skipForward() {
	global firefoxReadingIsActive
	if (firefoxReadingIsActive) {
		prolongateReaderMode()
		clickReadingControls()
		clickReadNextParagraph()
		clickReadingControls()
	}
}

skipBack() {
	global firefoxReadingIsActive
	if (firefoxReadingIsActive) {
		prolongateReaderMode()
		clickReadingControls()
		clickReadPrevParagraph()
		clickReadingControls()
	}
}


; Чтение буфера обмена
readThroughClipboard() {
	stopNVDA()
	Sleep, 1500
	Click, 11, 118
	Send, ^a
	Send, ^c
	readClipboard()
}

readingIsActive() {
	return ((Process, Exist, balcon.exe) OR (firefoxReadingIsActive))
}


getWinTitle() {
	WinGetTitle, titleOfActiveWin, A
	return titleOfActiveWin
}

isYoutubeVideo() {
	winTitle := getWinTitle()
    videoPattern := " - YouTube - Mozilla Firefox"
	foundPos := RegExMatch(winTitle, videoPattern)
	return (0 != foundPos)
}

videoPlayPause() {
	global readerModeIsActive
	
	if ( readerModeIsActive ) {
		if ( isYoutubeVideo() ) {
			Click, 65, 529
		}
	}
}

videoSkipForward() {
	global readerModeIsActive
	
	if ( readerModeIsActive ) {
		if ( isYoutubeVideo() ) {
			Send, {Right}
		}
	}
}

videoSkipBack() {
	global readerModeIsActive
	
	if ( readerModeIsActive ) {
		if ( isYoutubeVideo() ) {
			Send, {Left}
		}
	}
}


; Функции определения текущего режима
isVideoMode() {
	global video_mode_image_pattern
	ImageSearch, OutputVarX, OutputVarY, 65, 110, 160, 140, %video_mode_image_pattern%
	return (OutputVarX && OutputVarY)
}


; Временные отладочные функции
alertTitle() {
	if ( isYoutubeVideo() ) {
		title := getWinTitle()
		MsgBox,,, "TRUE"
	} else {
		MsgBox,,, "FALSE"
	}
}



; Логика
if (Process, Exist, nvda.exe) {
	nvdaIsRun := true
} else {
	nvdaIsRun := false
}




startReaderModeTimeout() {
	global readerModeTimeout
	global readerModeIsActive
	while (readerModeTimeout > 0) {
		Sleep, 1000
		readerModeTimeout := readerModeTimeout - 1
	}
	readerModeIsActive := false
}



ScrollLock::
toggleReaderMode()
return


~Numpad7::
openTextSearch()
return

~Numpad3::
openVideoSearch()
return

~Numpad9::
openMail()
return


F1::
nextLink()
;focusFirefox()
;Click, 200, 200
;Send, ^a
;Sleep, 100
;Send, ^c
;say(clipboard)
return

~F2::
prevLink()
return

F3::
openLink()
return

~F4::
closeTab()
return

F6::
if (readerModeIsActive) {
	startStopReading()
}
return


~a::
if (readerModeIsActive) {
	if (isVideoMode()) {
		videoSkipBack()
	}
	;skipBack()
}
return

~s::
if (readerModeIsActive) {
	if (isVideoMode()) {
		videoPlayPause()
	}
	;else if (isTextMode()) {
	;	startStopReading()
	;}
}
return

~d::
if (readerModeIsActive) {
	if (isVideoMode()) {
		videoSkipForward()
	}
	;skipForward()
}
return

~F7::
startNVDA()
return

;^#z::
;Process, Close, nvda.exe
;Runwait, taskkill /im firefox.exe /f
;return

; Блоки с метками
WindowTitleCheck:
	WinGetTitle, newWinTitle, ahk_class MozillaWindowClass
	if (titleOfActiveWin != newWinTitle) {
		MsgBox, , 'Заголовок изменился', %newWinTitle%
		SetTimer, WindowTitleCheck, Off
	}
return

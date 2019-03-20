#SingleInstance Force

; Настройки
readerModeIcon_Active := "C:\Users\User\Documents\reader\icons\reader-mode-active.png"
readerModeIcon_Inactive := "C:\Users\User\Documents\reader\icons\reader-mode-inactive.png"
web_server_command := "C:\Program Files (x86)\hfs.exe"
tab_open_delay := 500 ;Важная задержка на то, чтобы дать новой вкладке открыться

; Глобальные переменные
isReaderMode := false

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
	global isReaderMode

	isReaderMode := !isReaderMode
	if (isReaderMode) {
		startWebServer()
		Menu, Tray, Icon, %readerModeIcon_Active%
	} else {
		Menu, Tray, Icon, %readerModeIcon_Inactive%
	}
}

prolongateReaderMode() {
	global isReaderMode
	isReaderMode := true
}


openTextSearch() {
	global isReaderMode
	if (isReaderMode) {
		activateTextSearch()
	}
}

openVideoSearch() {
	global isReaderMode
	if (isReaderMode) {
		activateVideoSearch()
	}
}

openMail(){
	global isReaderMode
	if (isReaderMode) {
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
	if (firefoxIsOpened()) {
		focusFirefox()
		ImageSearch, imageX, imageY, 76, 47, 100, 72, c:\Users\User\Pictures\firefox-page-load-complete.bmp
		return (imageX and imageY)
	} else {
		;pronounceError "Фаерфокс не запущен!"
		return false
	}
}

nextLink(){
	global isReaderMode
	if (isReaderMode) {
		prolongateReaderMode()
		startNVDA()
		focusFirefox()
		Send, `t
	}
}

prevLink(){
	global isReaderMode
	if (isReaderMode) {
		prolongateReaderMode()
		startNVDA()
		focusFirefox()
		Send, +`t
	}
}

openLink(){
	global isReaderMode
	global tab_open_delay

	if (isReaderMode) {
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
	global isReaderMode
	if (isReaderMode) {
		focusFirefox()
		Send, {Ctrl down}w{Ctrl up}
	}
	firefoxReadingIsActive := false
	stopReadClipboard()
}


; Работа с режимом чтения Firefox
isReaderModeAvailable() {
	ImageSearch, imageX, imageY, 1132, 46, 1158, 73, c:\Users\User\Pictures\firefox-reader-mode-start-icon.png
	return (imageX and imageY)
}

isReaderModeActivated() {
	ImageSearch, imageX, imageY, 0, 168, 45, 211, c:\Users\User\Pictures\firefox-reader-mode-start-icon.png
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
	global isReaderMode
	
	if ( isReaderMode ) {
		if ( isYoutubeVideo() ) {
			Click, 65, 529
		}
	}
}

videoSkipForward() {
	global isReaderMode
	
	if ( isReaderMode ) {
		if ( isYoutubeVideo() ) {
			Send, {Right}
		}
	}
}

videoSkipBack() {
	global isReaderMode
	
	if ( isReaderMode ) {
		if ( isYoutubeVideo() ) {
			Send, {Left}
		}
	}
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
	global isReaderMode
	while (readerModeTimeout > 0) {
		Sleep, 1000
		readerModeTimeout := readerModeTimeout - 1
	}
	isReaderMode := false
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
if (isReaderMode) {
	startStopReading()
}
return


~a::
if (isReaderMode) {
	;videoSkipBack()
	skipBack()
}
return

~s::
if (isReaderMode) {
	startStopReading()
}
;videoPlayPause()
return

~d::
if (isReaderMode) {
	;videoSkipForward()
	skipForward()
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

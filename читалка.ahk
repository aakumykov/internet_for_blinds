#SingleInstance Force
;CoordMode, Pixel, Screen

; Настройки
program_name := "reader_for_blinds"
system_data_dir := A_AppDataCommon . "\" . program_name
last_run_file := system_data_dir . "\last_run.ini"
firefox_cold_start_threshold := 3600*8 	; в секундах

reader_mode_active_tray_icon := A_ScriptDir . "\images\tray-icons\reader-mode-active.png"
reader_mode_inactive_tray_icon := A_ScriptDir . "\images\tray-icons\reader-mode-inactive.png"
page_is_loaded_image_pattern := A_ScriptDir . "\images\browser\firefox-page-load-complete.bmp"

; Верхняя иконка режима чтения
reader_mode_top_x1 := 1108
reader_mode_top_y1 := 43
reader_mode_top_x2 := 1125
reader_mode_top_y2 := 62

reader_mode_available_top_icon  := A_ScriptDir . "\images\browser\reader-mode-available-top.bmp"
reader_mode_activated_top_icon  := A_ScriptDir . "\images\browser\reader-mode-enabled-top.bmp"

; Боковая иконка режима чтения
reader_mode_side_x1 := 0
reader_mode_side_y1 := 163
reader_mode_side_x2 := 39
reader_mode_side_y2 := 243

reader_mode_enabled_side_icon := A_ScriptDir . "\images\browser\reader-mode-enabled-side-icon-small.bmp"


video_mode_image_pattern := A_ScriptDir . "\images\browser\youtube.png"

web_server_command := "C:\Program Files (x86)\hfs.exe"

tab_open_delay := 500 ; Важная задержка на то, чтобы дать новой вкладке открыться


; Звуки
sounds_dir := A_ScriptDir . "\sounds\ru\"


; Глобальные переменные
scriptIsEnabled := false
playIsActive := false

isTextMode := false
isVideoMode := false
isMailMode := false

readerModeTimeout := 120
nvdaIsRun := false
firefoxReadingIsActive := false


; Функции
toggleScriptMode() {
	global reader_mode_active_tray_icon
	global reader_mode_inactive_tray_icon
	global scriptIsEnabled

	scriptIsEnabled := !scriptIsEnabled
	if (scriptIsEnabled) {
		startWebServer()
		Menu, Tray, Icon, %reader_mode_active_tray_icon%
	} else {
		Menu, Tray, Icon, %reader_mode_inactive_tray_icon%
	}
}

prolongateReaderMode() {
	global scriptIsEnabled
	scriptIsEnabled := true
}


openTextSearch() {
	global scriptIsEnabled
	if (scriptIsEnabled) {
		activateTextSearch()
	}
}

openVideoSearch() {
	global scriptIsEnabled
	if (scriptIsEnabled) {
		activateVideoSearch()
	}
}

openMail(){
	global scriptIsEnabled
	if (scriptIsEnabled) {
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
	global scriptIsEnabled
	if (scriptIsEnabled) {
		prolongateReaderMode()
		startNVDA()
		focusFirefox()
		Send, `t
	}
}

prevLink(){
	global scriptIsEnabled
	if (scriptIsEnabled) {
		prolongateReaderMode()
		startNVDA()
		focusFirefox()
		Send, +`t
	}
}

openLink(){
	global scriptIsEnabled
	global tab_open_delay

	if (scriptIsEnabled) {
		stopNVDA()
		focusFirefox()

		sayPageIsOpening()

		Send, {Return}
		Sleep, %tab_open_delay%

		while (!pageIsLoaded()) {
			Sleep, 100
		}

		readPage()
	}
}

closePage(withVoice){
	global scriptIsEnabled
	if (scriptIsEnabled) {
		focusFirefox()
		Send, {Ctrl down}w{Ctrl up}
	}
	firefoxReadingIsActive := false
	stopReadClipboard()
	
	if (withVoice)
		sayPageHasClosed()
}


; Работа с режимом чтения Firefox
readPage() {
	if (!readerModeAvailable()) {
		sayNoReadableVersion()
		closePage(false)
		return
	}

	sayPageHasOpened()
	activateReaderMode()
	Sleep, 2000
	textPlayPause()
}

sayPageIsOpening() {
	playSound("page-is-opening.mp3")
}

sayPageHasOpened() {
	playSound("page-has-opened.mp3")
}

sayPageHasClosed() {
	playSound("page-has-closed.mp3")
}

sayNoReadableVersion() {
	playSound("no-readable-version.mp3")
}

sayPause() {
	playSound("pause.mp3")
}



readerModeAvailable() {
	CoordMode, Pixel, Screen

	global reader_mode_available_top_icon
	global reader_mode_top_x1
	global reader_mode_top_y1
	global reader_mode_top_x2
	global reader_mode_top_y2

	ImageSearch, topIconX, topIconY, reader_mode_top_x1, reader_mode_top_y1, reader_mode_top_x2, reader_mode_top_y2, %reader_mode_available_top_icon%

	CoordMode, Pixel

	return (topIconX and topIconY)
}

isReaderMode() {
	global reader_mode_activated_top_icon
	global reader_mode_top_x1
	global reader_mode_top_y1
	global reader_mode_top_x2
	global reader_mode_top_y2

	global reader_mode_enabled_side_icon
	global reader_mode_side_x1
	global reader_mode_side_y1
	global reader_mode_side_x2
	global reader_mode_side_y2
	
	CoordMode, Pixel, Screen

	ImageSearch, topX, topY, reader_mode_top_x1, reader_mode_top_y1, reader_mode_top_x2, reader_mode_top_y2, %reader_mode_activated_top_icon%

	ImageSearch, sideX, sideY, reader_mode_side_x1, reader_mode_side_y1, reader_mode_side_x2, reader_mode_side_y2, %reader_mode_enabled_side_icon%

	CoordMode, Pixel

	return (topX and topY and sideX and sideY)
}

; TODO: сделать ПОИСК кнопки режима чтения, так как из-за значков дополнений она смещается
activateReaderMode() {
	Click, 1116, 53
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

playPause() {
	global scriptIsEnabled
	global playIsActive

	if (scriptIsEnabled) {

		stopNVDA()

		playIsActive := !playIsActive
		if (!playIsActive) {
			sayPause()
		}

		if (isVideoMode()) {
			videoPlayPause()
		}
		else if (isReaderMode()) {
			textPlayPause()
		}
	}
}

skipBack() {
	global scriptIsEnabled

	if (scriptIsEnabled) {
		if (isVideoMode()) {
			videoSkipBack()
		}
		else if (isReaderMode()) {
			textSkipBack()
		}
	}
}

skipForward() {
	global scriptIsEnabled

	if (scriptIsEnabled) {
		if (isVideoMode()) {
			videoSkipForward()
		}
		else if (isReaderMode()) {
			textSkipForward()
		}
	}
}

textPlayPause() {
	global firefoxReadingIsActive

	if (!firefoxReadinsgIsActive) {
		prolongateReaderMode()
		focusFirefox()
		clickReadingControls()
		clickPlayPause()
		clickReadingControls()
		firefoxReadingIsActive := true
	}
	else {
		prolongateReaderMode()
		focusFirefox()
		clickReadingControls()
		clickPlayPause()
		clickReadingControls()
		firefoxReadingIsActive := false
	}
}

textSkipForward() {
	global firefoxReadingIsActive
	if (firefoxReadingIsActive) {
		prolongateReaderMode()
		clickReadingControls()
		clickReadNextParagraph()
		clickReadingControls()
	}
}

textSkipBack() {
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
	global scriptIsEnabled
	
	if ( scriptIsEnabled ) {
		if ( isYoutubeVideo() ) {
			Click, 65, 529
		}
	}
}

videoSkipForward() {
	global scriptIsEnabled
	
	if ( scriptIsEnabled ) {
		if ( isYoutubeVideo() ) {
			Send, {Right}
		}
	}
}

videoSkipBack() {
	global scriptIsEnabled
	
	if ( scriptIsEnabled ) {
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
	global scriptIsEnabled
	while (readerModeTimeout > 0) {
		Sleep, 1000
		readerModeTimeout := readerModeTimeout - 1
	}
	scriptIsEnabled := false
}



; Высокоуровневые функции (первого уровня)
startSearch() {
	startFirefox("http://ya.ru")
}


; Функции второго уровня
startFirefox(url) {
	if (!isFirefoxRunning()) {
		last_run_timeout := getLastRunTimeout()
		
		if ((-1 == last_run_timeout) or (%last_run_timeout% > %firefox_cold_start_threshold%)) {
			informAboutColdStart()
		}
		else {
			informAboutOpeningSearch()
		}
		
		saveLastRunTime()

	} else {
		focusFirefox()
	}
	
	Run, firefox.exe %url%, C:\Program Files\Mozilla Firefox\
}

informAboutOpeningSearch() {
	;playSoundFile("C:\Users\User\Documents\reader\sounds\ru\opening-search.mp3")
	playSoundFile("C:\Users\User\Documents\reader\sounds\ru\search-slowly-opening.mp3")
}

informAboutColdStart() {
	playSoundFile("C:\Users\User\Documents\reader\sounds\ru\cold-start-wait.mp3")
}


; Функции третьего уровня
isFirefoxRunning() {
	Process, Exist, firefox.exe
	return (0 != %ErrorLevel%)
}


; Вспомогательные функции
createSystemDataDir() {
	global system_data_dir
	if (!FileExist(system_data_dir)) {
		FileCreateDir, %system_data_dir%
	}
}

saveLastRunTime() {
	global last_run_file
	createSystemDataDir()
	IniWrite, %A_Now%, %last_run_file%, Common, last_run_time
}

getLastRunTimeout() {
	global last_run_file
	IniRead, lr_time, %last_run_file%, Common, last_run_time, -1
	if (-1 == lr_time) 
		return -1
	else
		return A_Now - lr_time
}

playSoundFile(fullFilePath) {
	Run, mpg123.exe %fullFilePath%, C:\Program Files\mpg123, Hide
}

playSound(soundFileName) {
	global sounds_dir
	playSoundFile(sounds_dir . "\" . soundFileName)
}


; СДЕЛАТЬ: остановка чтения ситаницы9при запуске поиска


ScrollLock::
toggleScriptMode()
return

; СДЕЛАТЬ: фокус окна Firefox при запуске поиска и т.д.
~Numpad7::
;openTextSearch()
startSearch()
return

~Numpad3::
openVideoSearch()
return

~Numpad9::
openMail()
return


F1::
nextLink()
return

F2::
prevLink()
return

F3::
openLink()
return

F4::
closePage(true)
return

F6::
if (scriptIsEnabled) {
	textPlayPause()
}
return

F7::
; if (readerModeAvailable()) {
; 	MsgBox "READER MODE AVAILABLE " + %ErrorLevel%
; } else {
; 	MsgBox "READER MODE =NOT= AVAILABLE " + %ErrorLevel%
; }
readPage()
return

F8::
; if (isReaderMode()) {
; 	MsgBox "READER MODE ACTIVE " + %ErrorLevel%
; } else {
; 	MsgBox "READER MODE NOT ACTIVE " + %ErrorLevel%
; }
sayPageHasOpened()
return

~a::
skipBack()
return

~s::
playPause()
return

~d::
skipForward()
return



; Блоки с метками
WindowTitleCheck:
	WinGetTitle, newWinTitle, ahk_class MozillaWindowClass
	if (titleOfActiveWin != newWinTitle) {
		MsgBox, , 'Заголовок изменился', %newWinTitle%
		SetTimer, WindowTitleCheck, Off
	}
return

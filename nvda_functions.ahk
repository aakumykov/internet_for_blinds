
startNVDA(wait_until_starting) {
	global nvda_cmd
	
	if (!nvdaIsRun()) {

		playSound("screen-reader-is-starting.mp3")

		Run, %nvda_cmd%, , UseErrorLevel

		; if (wait_until_starting) {
		; 	while (!nvdaIsRun()) {
		; 		Sleep, 100
		; 	}
		; }

		waitForEventDuringSeconds("nvdaIsRun", 3000)
	}
}

nvdaIsRun() {
	Process, Exist, nvda.exe
	return 0 != ErrorLevel
}

stopNVDA() {
	global nvda_cmd
	Run, %nvda_cmd% -q, , UseErrorLevel

	; Альтернативный метод
	; Process, Close, nvda.exe
	; Process, Close, nvda_eoaProxy.exe
	; Process, Close, nvdaHelperRemoteLoader.exe
}

muteNVDA() {
	global nircmd
	Run, %nircmd% muteappvolume nvda.exe 1
}

unmuteNVDA() {
	global nircmd
	Run, %nircmd% muteappvolume nvda.exe 0
}

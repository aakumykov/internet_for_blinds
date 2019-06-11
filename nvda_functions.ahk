
nvdaIsRun() {
	return Process, Exist, nvda.exe
}

startNVDA() {
	if (!nvdaIsRun()) {
		Run, nvda.exe, "C:\Program Files (x86)\NVDA", UseErrorLevel
	}
}

stopNVDA() {
	Run, nvda.exe -q, "C:\Program Files (x86)\NVDA", UseErrorLevel

	; Альтернативный метод
	; Process, Close, nvda.exe
	; Process, Close, nvda_eoaProxy.exe
	; Process, Close, nvdaHelperRemoteLoader.exe
}
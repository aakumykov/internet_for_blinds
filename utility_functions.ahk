
waitForEventDuringSeconds(testFuncName, timeout) {
	func := Func(testFuncName)

	passed_time := 0
	sleep_step := 100 ; milliseconds

	while (!func.() && passed_time < timeout) {
		Sleep, sleep_step
		passed_time := passed_time + sleep_step
	}
}

testClipboardWithRegex(regex){
	return RegExMatch(clipboard, regex)
}
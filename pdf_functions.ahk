
is_pdf_mode() {
	return testClipboardWithRegex("i)\.pdf$")
}

pdf2html() {
	focusFirefox()

	clickInsidePdf()
	copyContent2clipboard()
	clickInsidePdf()

	saveClipboard2file()
}

clickInsidePdf() {
	Click, 500, 500
}

copyContent2clipboard() {
	Send, ^{a}
	Sleep, 200
	Send, ^{c}
}

saveClipboard2file() {
	Random, randomNumber , 1000, 2000
	outputFileName := "clipboard_" . randomNumber . ".html"

	FileAppend, "<!DOCTYPE html><html><head><meta charset='utf-8'><title>", C:\Temp\%outputFileName%, UTF-8
	FileAppend, %randomNumber%, C:\Temp\%outputFileName%, UTF-8
	FileAppend, "</title></head><body><pre>", C:\Temp\%outputFileName%, UTF-8

	FileAppend, %clipboard%, C:\Temp\%outputFileName%, UTF-8

	FileAppend, "</pre></body></html>", C:\Temp\%outputFileName%, UTF-8
}
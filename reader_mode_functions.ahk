textSkipForward() {
	clickReadingControls()
	clickReadNextParagraph()
	clickReadingControls()
}

textSkipBack() {
	clickReadingControls()
	clickReadPrevParagraph()
	clickReadingControls()
}

clickReadingControls() {
	Click 22, 227
}

clickReadNextParagraph() {
	Click, 301, 222
}

clickReadPrevParagraph() {
	Click, 102, 222
}


videoPlayPause() {
	if (modeStack.isRedlineVideoMode()) {
		redlineVideoPlayPause()
	}

	if (modeStack.isYoutubeVideoMode()) {
		youtubeVideoPlayPause()
	}

	LogError(A_LineFile, A_LineNumber, "unknown video mode: " . modeStack.getCurrentMode())
}

videoSkipForward() {
	Send, {Right}
}

videoSkipBack() {
	Send, {Left}
}

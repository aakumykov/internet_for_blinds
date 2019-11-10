
videoPlayPause() {
	if (modeStack.isRedlineVideoMode()) {
		redlineVideoPlayPause()
		return
	}

	if (modeStack.isYoutubeVideoMode()) {
		youtubeVideoPlayPause()
		return
	}

	if (modeStack.isYandexVideoMode()) {
		yandexVideoPlayPause()
		return
	}

	if (modeStack.isRedlineLiveMode()) {
		redlineLivePlayPause()
		return
	}

	reportUnknownMode("videoPlayPause()")
}

videoSkipForward() {
	; MsgBox "videoSkipForward"
	Send, {Right}
}

videoSkipBack() {
	; MsgBox "videoSkipBack"
	Send, {Left}
}


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

	reportUnknownMode()
}

videoSkipForward() {
	Send, {Right}
}

videoSkipBack() {
	Send, {Left}
}

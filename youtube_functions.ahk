
is_video_search_results_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/results\?search_query=")
}

is_youtube_video_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/watch\?")
}

youtubeVideoPlayPause() {
	Click, 427, 420
	Sleep, 100 ; Для предотвращения перехода в полноэкранный режим из-за двойного щелчка
}

youtubeClickAtEmptyPlace() {
	Click, 200, 120
}
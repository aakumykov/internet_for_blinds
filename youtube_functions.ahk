
is_video_search_results_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/results\?search_query=")
}

is_youtube_video_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/watch\?")
}

youtubeVideoPlayPause() {
	global youtube_play_button_x
	global youtube_play_button_y
	Sleep, 100 ; Для предотвращения перехода в полноэкранный режим из-за двойного щелчка
}

youtubeClickAtEmptyPlace() {
	global youtube_empty_place_x
	global youtube_empty_place_y
	Click, youtube_empty_place_x, youtube_empty_place_y
}

is_video_search_results_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/results\?search_query=")
}

is_youtube_video_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/watch\?")
}

youtubeVideoPlayPause() {
	Click, 713, 457
}

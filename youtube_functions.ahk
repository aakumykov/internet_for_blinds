
is_youtube_video_mode() {
	return testClipboardWithRegex("^https://www\.youtube\.com/watch\?")
}

youtubeVideoPlayPause() {
	Click, 65, 529
}

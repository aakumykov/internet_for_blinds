
LogError(file, line, message) {
	global log_file

	textLine := A_Now . ", " . file . ":" . line . ", " . message

	FileAppend, 
	(
		%textLine%

	), %log_file%
}

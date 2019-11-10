
playSound(soundFileName) {
	global sounds_dir
	playSoundFile(sounds_dir . "\" . soundFileName)
}

playSoundFile(fullFilePath) {
	; global sound_player_command
	Run, "c:\Program Files\mpg123.exe" "%fullFilePath%", , Hide, playerPID
	return %playerPID%
}
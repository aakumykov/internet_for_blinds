
playSound(soundFileName) {
	global sounds_dir
	playSoundFile(sounds_dir . "\" . soundFileName)
}

playSoundFile(fullFilePath) {
	global sound_player_command
	;Run, sound_player_command %fullFilePath%, , Hide
	Run, "c:\Program Files\mpg123\mpg123.exe" %fullFilePath%, , Hide
}


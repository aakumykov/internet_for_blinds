
playSound(soundFileName) {
	global sounds_dir
	; MsgBox % sounds_dir

	soundFile := sounds_dir . "\" . soundFileName
	; if FileExist(soundFile)
	; 	MsgBox "file exists"
	; Else
	; 	MsgBox "file does not exists"

	playSoundFile(soundFile)
}

playSoundFile(fullFilePath) {
	; MsgBox % fullFilePath

	global sound_player_command
	;Run, sound_player_command %fullFilePath%, , Hide
	Run, "c:\Program Files\mpg123\mpg123.exe" %fullFilePath%, , Hide
}


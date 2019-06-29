
playSound(soundFileName) {
	global sounds_dir
	playSoundFile(sounds_dir . "\" . soundFileName)
}

playSoundFile(fullFilePath) {
	Run, mpg123.exe %fullFilePath%, C:\Program Files\mpg123, Hide
}



startWebServer() {
	global web_server_command
	;if (! Process, Exist, hfs.exe ) {
		; В настройках HTTPFileServer-а сделано "запускать одну копию",
		; так что можно не проверять (тем более, проверка не работает).
		Run, %web_server_command%, UseErrorLevel
	;}
}


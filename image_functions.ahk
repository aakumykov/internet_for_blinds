
images_dir := A_ScriptDir . "\images\"


searchImage(imageFileName, x1, y1, x2, y2) {
	CoordMode, Pixel, Screen

	images_dir := A_ScriptDir . "\images\"
	filePath := images_dir . "\" . imageFileName

	if (!FileExist(filePath)) {
		Throw, %filePath% . " does not exists!"
	}

	ImageSearch, OutputVarX, OutputVarY, 165, 39, 273, 66, %filePath%

	return (OutputVarX && OutputVarY)
}

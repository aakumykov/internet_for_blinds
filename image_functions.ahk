images_dir := A_ScriptDir . "\images\"

searchImage2(image_pattern_file_name, x1, y1, x2, y2, use_absolute_coords) {

	global images_dir

	image_pattern_file_path := images_dir . "\" . image_pattern_file_name

	if (!FileExist(image_pattern_file_path)) {
		Throw, "image '" . image_pattern_file_path . "' pattern not found"
		return
	}

	if (use_absolute_coords) {
		CoordMode, Pixel, Screen
	} else {
		CoordMode, Pixel, Window
	}

	ImageSearch, OutputVarX, OutputVarY, x1, y1, x2, y2, %image_pattern_file_path%

	return (OutputVarX and OutputVarY)
}

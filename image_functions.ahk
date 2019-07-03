

searchImage(image_pattern_file_name, x1, y1, x2, y2, relative_mode) {
	global images_dir

	image_pattern_file_path := images_dir . "\" . image_pattern_file_name

	if (!FileExist(image_pattern_file_path)) {
		Throw, "image '" . image_pattern_file_path . "' pattern not found"
		return
	}

	if (relative_mode) {
		CoordMode, Pixel, Window
	}
	else {
		CoordMode, Pixel, Screen
	}

	ImageSearch, OutputVarX, OutputVarY, x1, y1, x2, y2, %image_pattern_file_path%

	if (2 == ErrorLevel) {
		Throw, "CANNOT PRODUCE IMAGESEARCH"
	}

	return (OutputVarX and OutputVarY)
}




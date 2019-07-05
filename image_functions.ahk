
; findImage(pattern_file_name) {
; 	global images_dir
; 	global reader_mode_serch_area_x1
; 	global reader_mode_serch_area_y1
; 	global reader_mode_serch_area_x2
; 	global reader_mode_serch_area_y2

; 	imageFile := images_dir . "\" . pattern_file_name

; 	ImageSearch, OutputVarX, OutputVarY, reader_mode_serch_area_x1, reader_mode_serch_area_y1, reader_mode_serch_area_x2, reader_mode_serch_area_y2, %imageFile%

; 	if (2==ErrorLevel) {
; 		Throw, "CANNOT PRODUCE ImageSearch"
; 	}

; 	return 0 == ErrorLevel
; }


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




is_fips_mode() {
	
	if (testClipboardWithRegex("^https://kpsrtz\.fips\.ru/?$")) {
		return true
	}

	if (testClipboardWithRegex("^https://kpsrtz\.fips\.ru/Application/Documents/[0-9]+$")) {
		return true
	}

	return false
}
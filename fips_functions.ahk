is_fips_mode() {
	
	if (testClipboardWithRegex("^https://www\.fips\.ru/registers-doc-view/fips_servlet\?DB=")) {
		return true
	}

	if (testClipboardWithRegex("^http://127\.0\.0\.1/fips-status/patent-request-statuses\.html$")) {
		return true
	}

	return false
}
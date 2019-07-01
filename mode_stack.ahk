class ModeStack {

	prev_mode := ""
	current_mode := ""


	; Методы-определители
	isTextMode() {
		; if (this.isRedlineTextMode()) {
		; 	return true
		; }
		; return false
		return "TEXT_MODE" == this.current_mode
	}

	isVideoMode() {
		if (this.isYoutubeVideoMode()) {
			return true
		}
		if (this.isRedlineVideoMode()) {
			return true
		}
		return false
	}

	isReaderMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "READER_MODE" == this.current_mode
	}


	; Методы общего назначения
	getCurrentMode() {
		return this.current_mode
	}
	
	addMode(newMode) {
		this.prev_mode := this.current_mode
		this.current_mode := newMode
	}

	addEmptyMode() {
		this.prev_mode := this.current_mode
		this.current_mode := ""
	}

	popMode() {
		this.current_mode := this.prev_mode
		this.prev_mode := ""
	}


	; Методы установки разных режимов
	addSearchMode() {
		this.addMode("SEARCH_MODE")
	}
	isSearchMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "SEARCH_MODE" == this.current_mode
	}


	addListMode() {
		this.addMode("LIST_MODE")
	}
	isListMode() {
		if ("" == this.current_mode) {
			detectMode()
		}

		if ("LIST_MODE" == this.current_mode) {
			return true
		}
		
		if (this.isMailListMode()) {
			return true
		}
		
		if (this.isRedlineListMode()) {
			return true
		}

		if (this.isSearchMode()) {
			return true
		}
	}


	addMailListMode() {
		this.addMode("MAIL_LIST_MODE")
	}
	isMailListMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "MAIL_LIST_MODE" == this.current_mode
	}


	addReaderMode() {
		this.addMode("READER_MODE")
	}
	addTextMode() {
		this.addMode("TEXT_MODE")
	}


	addRedlineListMode() {
		this.addMode("REDLINE_LIST_MODE")
	}
	isRedlineListMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "REDLINE_LIST_MODE" == this.current_mode
	}


	addRedlineVideoMode() {
		this.addMode("REDLINE_VIDEO_MODE")
	}
	isRedlineVideoMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "REDLINE_VIDEO_MODE" == this.current_mode
	}


	addRedlineTextMode() {
		this.addMode("REDLINE_TEXT_MODE")
	}
	isRedlineTextMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "REDLINE_TEXT_MODE" == this.current_mode
	}


	addYoutubeVideoMode() {
		this.addMode("YOUTUBE_VIDEO_MODE")
	}
	isYoutubeVideoMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "YOUTUBE_VIDEO_MODE" == this.current_mode
	}


}

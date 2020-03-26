class ModeStack {

	pm := ""
	cm := ""

	; Методы-определители
	isTextMode() {
		return "TEXT_MODE" == this.cm
	}

	isVideoMode() {
		if (this.isYoutubeVideoMode()) {
			return true
		}
		if (this.isRedlineVideoMode()) {
			return true
		}
		if (this.isYandexVideoMode()) {
			return true
		}
		if (this.isRedlineLiveMode()) {
			return true
		}
		return false
	}

	isReaderMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "READER_MODE" == this.cm
	}


	; Методы общего назначения
	getCurrentMode() {
		return this.cm
	}

	clearCurrentMode() {
		this.cm := ""
	}
	
	addMode(newMode) {
		TrayTip, addMode(), %newMode%, 1
		this.pm := this.cm
		this.cm := newMode

		; cm := this.cm
		; pm := this.pm
		; MsgBox, , addMode(%newMode%), pm: %pm%`, cm: %cm%
	}

	popMode() {
		; cm := this.cm
		; pm := this.pm
		; MsgBox, , "popMode()", pm: %pm% ==> cm: %cm%

		this.cm := this.pm
		this.pm := ""
	}

	setMode(newMode) {
		; pm := this.pm
		; cm := this.cm
		;MsgBox 1 setMode(%newMode%), pm: %pm%, cm: %cm%

		this.cm := newMode

		; pm := this.pm
		; cm := this.cm
		; MsgBox 2 setMode(%newMode%), pm: %pm%, cm: %cm%
	}

	addEmptyMode() {
		this.pm := this.cm
		this.cm := ""
	}


	; Методы установки разных режимов
	addSearchMode() {
		this.addMode("SEARCH_MODE")
	}
	isSearchMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "SEARCH_MODE" == this.cm
	}


	addListMode() {
		this.addMode("LIST_MODE")
	}
	isListMode() {
		if ("" == this.cm) {
			detectMode()
		}

		if ("LIST_MODE" == this.cm) {
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

		if (this.isFIPSMode()) {
			return true
		}
	}


	addMailListMode() {
		this.addMode("MAIL_LIST_MODE")
	}
	isMailListMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "MAIL_LIST_MODE" == this.cm
	}
	isFIPSMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "LIST_MODE" == this.cm
	}


	; Внимание! Так как режим чтения /заменяет/ собой текстовый
	; режим, здесь внутри метода setReaderMode() делается вызов
	; setMode() вместо addMode()
	setReaderMode() {
		; MsgBox "setReaderMode()"
		this.setMode("READER_MODE")
	}

	addTextMode() {
		this.addMode("TEXT_MODE")
	}


	addRedlineListMode() {
		this.addMode("REDLINE_LIST_MODE")
	}
	isRedlineListMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "REDLINE_LIST_MODE" == this.cm
	}


	addRedlineVideoMode() {
		this.addMode("REDLINE_VIDEO_MODE")
	}
	isRedlineVideoMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "REDLINE_VIDEO_MODE" == this.cm
	}


	addRedlineTextMode() {
		this.addMode("REDLINE_TEXT_MODE")
	}
	isRedlineTextMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "REDLINE_TEXT_MODE" == this.cm
	}


	addRedlineLiveMode() {
		this.addMode("REDLINE_LIVE_MODE")
	}
	isRedlineLiveMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "REDLINE_LIVE_MODE" == this.cm
	}


	addYoutubeVideoMode() {
		this.addMode("YOUTUBE_VIDEO_MODE")
	}
	isYoutubeVideoMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "YOUTUBE_VIDEO_MODE" == this.cm
	}


	addYandexVideoMode() {
		this.addMode("YANDEX_VIDEO_MODE")
	}
	isYandexVideoMode() {
		if ("" == this.cm) {
			detectMode()
		}
		return "YANDEX_VIDEO_MODE" == this.cm
	}
}

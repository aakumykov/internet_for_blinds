class ModeStack {

	modes_stack := Array()
	current_mode := ""


	getCurrentMode() {
		return this.current_mode
	}
	
	addMode(newMode) {
		this.modes_stack.push(this.current_mode)
		this.current_mode := newMode
	}
	
	popMode() {
		lastMode := this.modes_stack.pop()
		this.current_mode := lastMode
	}

	clearCurrentMode() {
		this.current_mode := ""
	}

	clear() {
		this.modes_stack := Array()
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
}

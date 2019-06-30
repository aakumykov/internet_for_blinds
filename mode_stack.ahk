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

	addMailListMode() {
		this.addMode("MAIL_LIST_MODE")
	}


	isMailListMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return "MAIL_LIST_MODE" == this.current_mode
	}
	
	isListMode() {
		if ("" == this.current_mode) {
			detectMode()
		}
		return ("LIST_MODE" == this.current_mode || this.isMailListMode() )
	}

;	isVideoMode() {
;		current_mode := this.getCurrentMode()
;		return "VIDEO_MODE" == current_mode
;	}

}

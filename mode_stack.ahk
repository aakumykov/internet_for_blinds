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

	
;	isListMode() {
;		current_mode := this.getCurrentMode()
;		return "LIST_MODE" == current_mode
;	}

;	isVideoMode() {
;		current_mode := this.getCurrentMode()
;		return "VIDEO_MODE" == current_mode
;	}

}

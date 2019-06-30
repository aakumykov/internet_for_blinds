class ModeStack {

	modes_stack := Array()
	default_mode := "undefined"
	
	getCurrentMode() {
		len := this.modes_stack.length()
		if (0 == len) {
			return this.default_mode
		} else {
			return this.modes_stack[this.modes_stack.length()]
		}
	}
	
	addMode(modeName) {
		this.modes_stack.push(modeName)
	}
	
	getMode() {
		mode := this.modes_stack.pop()
		if ("" == mode) {
			return this.default_mode
		} else {
			return mode
		}
	}
	
	clearModes() {
		this.modes_stack := Array()
	}


	isListMode() {
		current_mode := this.getCurrentMode()
		return "LIST_MODE" == current_mode
	}

	isVideoMode() {
		current_mode := this.getCurrentMode()
		return "VIDEO_MODE" == current_mode
	}
}


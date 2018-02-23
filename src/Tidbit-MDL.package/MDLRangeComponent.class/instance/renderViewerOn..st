rendering
renderViewerOn: html

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId; type: 'hidden'; value: self value; callback: (GRDelayedSend receiver: self selector: #yourself).
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
		html mdlSlider
			disabled: true;
			id: self id, '-s'; min: -100; max: 100; on: #string of: self.
	].

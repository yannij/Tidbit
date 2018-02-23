rendering
renderEditorOn: html

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId; type: self inputType; on: self inputAspect of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

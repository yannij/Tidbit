rendering
renderViewerOn: html

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			readonly: true;
			id: self labelId; type: 'password'; on: #string of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

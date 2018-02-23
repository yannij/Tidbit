rendering
renderElementOn: html readonly: flag

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			readonly: flag;
			id: self labelId; type: 'password'; on: #string of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

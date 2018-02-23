rendering
renderEditorOn: html

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId; type: 'password'; on: #string of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].
	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId, '-verify'; type: 'password'; on: #verificationString of: self.
		html mdlTextFieldLabel
			for: self labelId, '-verify'; with: '*', self magritteDescription label.
	].

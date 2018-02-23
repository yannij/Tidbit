rendering
renderElement: flag on: html

	html mdlTextFieldContainer
		beFloatingLabelIf: true;
		beExpandableIf: true;
		with: [
		html mdlTextArea
			id: self labelId;
			rows: self magritteDescription lineCount;
			columns: 80;
			readonly: flag;
			on: #string of: self.

		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

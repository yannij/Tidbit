rendering
renderEditorOn: html

	html mdlCheckboxContainer with: [
		html mdlCheckbox
			id: self labelId;
			on: #value of: self.
		html mdlCheckboxLabel: self magritteDescription checkboxLabel ]
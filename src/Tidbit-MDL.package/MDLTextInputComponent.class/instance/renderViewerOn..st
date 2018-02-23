rendering
renderViewerOn: html

	"html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html."

	"html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId; type: 'text'; readonly: true; with: self string.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	]."
	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			readonly: true;
			id: self labelId; type: self inputType; on: self inputAspect of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

rendering
renderEditorOn: html

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId; type: 'hidden'; value: self value; callback: (GRDelayedSend receiver: self selector: #yourself).
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
		self requiresMultipartForm
			ifTrue: [ self renderUploadOn: html ]
			ifFalse: [ self renderRemoveOn: html ]
	].

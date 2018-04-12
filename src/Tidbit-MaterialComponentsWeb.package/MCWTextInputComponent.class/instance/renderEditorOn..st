rendering
renderEditorOn: html

	html div
		class: 'mdc-text-field mdc-text-field--upgraded';
		with: [
		html textInput
			class: 'mdc-text-field__input';
			id: self labelId; type: self inputType; on: self inputAspect of: self.
		html label
			for: self labelId;
			class: 'mdc-floating-label mdc-floating-label--float-above';
			with: self magritteDescription label.
		html div class: 'mdc-line-ripple'; style: 'transform-origin: 161px center 0px;'.
	].

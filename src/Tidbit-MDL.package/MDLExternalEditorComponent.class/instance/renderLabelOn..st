rendering
renderLabelOn: html

	html mdlCell size: 12; with: [
		html mdlTextFieldContainer floatingLabel; style: 'padding-bottom: 0px'; with: [
			html mdlTextFieldInput
				attributeAt: 'hidden' put: 'true'; style: 'height: 0px';
				id: self labelId; type: 'text'; value: ' '.
			html mdlTextFieldLabel
				for: self labelId; with: self magritteDescription label ] ].

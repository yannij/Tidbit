rendering
renderEditorOn: html
	| group |

	html mdlGrid class: 'mdl-grid--no-spacing'; with: [ 
		html mdlCell with: [
			html mdlTextFieldContainer floatingLabel; style: 'padding-bottom: 0px'; with: [
				html mdlTextFieldInput
					attributeAt: 'hidden' put: 'true'; style: 'height: 0px';
					id: self labelId; type: 'text'; value: ' '.
				html mdlTextFieldLabel
					for: self labelId; with: self magritteDescription label ] ].

		group := html radioGroup.
		self
			optionsWithIndexDo: [ :each :index | self renderOption: each index: index in: group on: html ]
			separatedBy: [ html mdlLayoutSpacer ] ].

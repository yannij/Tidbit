Class {
	#name : #MDLCheckboxGroupComponent,
	#superclass : #MACheckboxGroupComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLCheckboxGroupComponent >> renderEditorOn: html [

	html mdlGrid class: 'mdl-grid--no-spacing'; with: [ 
		html mdlCell with: [
			html mdlTextFieldContainer floatingLabel; style: 'padding-bottom: 0px'; with: [
				html mdlTextFieldInput
					attributeAt: 'hidden' put: 'true'; style: 'height: 0px';
					id: self labelId; type: 'text'; value: ' '.
				html mdlTextFieldLabel
					for: self labelId; with: self magritteDescription label ] ].

		html hiddenInput 
			callback: [ :value | self clear ].

		self
			optionsWithIndexDo: [ :each :index |
				| optionId |
				optionId := self optionId: index.
				html mdlCheckboxContainer with: [
					html mdlCheckbox
						id: optionId;
						value: (self selectedList includes: each);
						onTrue: [ self add: each ] 
						onFalse: [ self remove: each ].
					html mdlCheckboxLabel: (self labelForOption: each) ] ]
			separatedBy: [ html mdlLayoutSpacer ] ].

]

{ #category : #rendering }
MDLCheckboxGroupComponent >> renderViewerOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html.

]

Class {
	#name : #MDLRadioGroupComponent,
	#superclass : #MARadioGroupComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLRadioGroupComponent >> renderEditorOn: html [
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

]

{ #category : #rendering }
MDLRadioGroupComponent >> renderOption: anObject index: anInteger in: aRadioGroup on: html [
	| optionId |

	optionId := self optionId: anInteger.

	html
		mdlCell: [
			html mdlRadioContainer rippleEffect; for: optionId; with: [
				html mdlRadioButton
					id: optionId;
					group: aRadioGroup;
					selected: self value = anObject;
					callback: [ self value: anObject ].
				anObject isNil
					ifTrue: [ html mdlRadioLabel: [ html text: '(none)' ] ]
					ifFalse: [ html mdlRadioLabel: (self labelForOption: anObject) ] ] ] size: 12

]

{ #category : #rendering }
MDLRadioGroupComponent >> renderViewerOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html.

]

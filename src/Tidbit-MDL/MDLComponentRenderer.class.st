Class {
	#name : #MDLComponentRenderer,
	#superclass : #MAComponentRenderer,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLComponentRenderer >> renderContainer: aDescription [ 

	"html mdlGrid with: [
		html mdlCell size: 12; shadow: 2; stretch; with: [
			super renderContainer: aDescription ] ]"

	super renderContainer: aDescription

]

{ #category : #rendering }
MDLComponentRenderer >> renderControl: aDescription [

	^ super renderControl: aDescription
]

{ #category : #rendering }
MDLComponentRenderer >> renderElement: aDescription [

	html mdlCell
		style: 'margin: 0';
		size: 12;
		tabletSize: 8;
		phoneSize: 4;
		stretch;
		with: [ super renderElement: aDescription ].

	"super renderElement: aDescription"

]

{ #category : #rendering }
MDLComponentRenderer >> renderGroup: aDescription [

	super renderGroup: aDescription.

	"group isNil ifTrue: [ ^ self ].
	html definitionTerm
		class: 'group';
		with: group"
]

{ #category : #rendering }
MDLComponentRenderer >> renderLabel: aDescription [

	"self useBasicMagritte ifTrue: [ ^ self renderLabel: aDescription ]."

	"| label |
	aDescription hasLabel ifFalse: [ ^ self ].
	label := html mdlTextFieldLabel.
	(self childAt: aDescription) hasLabelId
		ifTrue: [ label for: (self childAt: aDescription) labelId ].
	label with: [ html render: aDescription label ]."

	"(self childAt: aDescription) isReadonly
		ifTrue: [ html text: aDescription label, ': ' ]"
]

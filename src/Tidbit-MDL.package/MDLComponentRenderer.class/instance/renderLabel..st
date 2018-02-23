rendering
renderLabel: aDescription

	"self useBasicMagritte ifTrue: [ ^ self renderLabel: aDescription ]."

	"| label |
	aDescription hasLabel ifFalse: [ ^ self ].
	label := html mdlTextFieldLabel.
	(self childAt: aDescription) hasLabelId
		ifTrue: [ label for: (self childAt: aDescription) labelId ].
	label with: [ html render: aDescription label ]."

	"(self childAt: aDescription) isReadonly
		ifTrue: [ html text: aDescription label, ': ' ]"
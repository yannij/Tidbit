rendering-buttons
renderSelectListOn: html
	"Do nothing - add button is rendered by table widget"
	"super renderSelectButtonOn: html"

	"true ifTrue: [^super renderSelectListOn: html].

	html render:
		(MDLSelectWidget
			possibilities: self classes
			inputLabel: self magritteDescription label
			labelBlock: [ :value | value label ]
			callback: [ :value | self selected: value ]
			selectedObject: self selected
			tooltip: 'description'
			sortBlock: [ :a :b | a <= b ])."

rendering
renderOption: anObject index: anInteger in: aRadioGroup on: html
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

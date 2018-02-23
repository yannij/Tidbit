rendering
renderEditorForUngroupedOn: html
	"html select
		id: self labelId;
		list: self options;
		selected: self value;
		callback: [ :value | self value: value ];
		labels: [ :value | self labelForOption: value ]."

	html render:
		(MDLSelectWidget
			possibilities: self options
			inputLabel: self magritteDescription label
			labelBlock: [ :value | value isNil ifTrue: ['(none)'] ifFalse: [self labelForOption: value] ]
			callback: [ :value | self value: value ]
			selectedObject: self value
			tooltip: 'description'
			sortBlock: [ :a :b | a <= b ]).

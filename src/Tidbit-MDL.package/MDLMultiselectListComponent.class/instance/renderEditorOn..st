rendering
renderEditorOn: html

	html text: self magritteDescription label, ':'; space.
	html multiSelect
		size: 8;
		id: self labelId;
		list: self availableList;
		selected: self selectedList;
		labels: [ :value | self labelForOption: value ];
		callback: [ :value | self value: value ].

	"html render:
		((MDLSelectWidget
			possibilities: self availableList
			inputLabel: self magritteDescription label
			labelBlock: [ :value | self labelForOption: value ]
			callback: [ :value | value ]
			selectedObject: self availableList first
			tooltip: 'description'
			sortBlock: [ :a :b | a <= b ])
				autoSubmit: false;
				yourself)."

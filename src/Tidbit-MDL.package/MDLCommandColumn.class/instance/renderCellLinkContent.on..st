rendering
renderCellLinkContent: anObject on: html
	self commands
		do: [ :each |
			(html mdlButton
				fab; miniFab;
				"raised;colored;"
				callback: [ each key value: anObject ];
				text: each value;
				"with: [ html mdlIcon: each value asSymbol ];"
				"with: [ html mdlIcon: #explore ];"
				yourself)]
		separatedBy: [ html space ]
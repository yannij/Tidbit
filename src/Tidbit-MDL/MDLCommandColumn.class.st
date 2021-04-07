Class {
	#name : #MDLCommandColumn,
	#superclass : #MACommandColumn,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLCommandColumn >> renderCell: anObject index: anInteger on: html [

"self halt."

	html mdlTableCell
		class: self tableDataClass;
		with: [ self renderer valueWithEnoughArguments: (Array with: anObject with: html with: anInteger) ]
]

{ #category : #rendering }
MDLCommandColumn >> renderCellFormContent: anObject on: html [
	self renderCellLinkContent: anObject on: html
]

{ #category : #rendering }
MDLCommandColumn >> renderCellLinkContent: anObject on: html [
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
]

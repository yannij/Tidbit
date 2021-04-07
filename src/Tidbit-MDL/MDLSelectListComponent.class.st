Class {
	#name : #MDLSelectListComponent,
	#superclass : #MASelectListComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLSelectListComponent >> renderEditorForUngroupedOn: html [
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

]

{ #category : #rendering }
MDLSelectListComponent >> renderViewerOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html.

]

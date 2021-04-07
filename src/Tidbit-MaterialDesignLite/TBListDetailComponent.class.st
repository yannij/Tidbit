Class {
	#name : #TBListDetailComponent,
	#superclass : #MDLOneToManyComponent,
	#instVars : [
		'viewStyle',
		'detailComponent'
	],
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #'accessing - defaults' }
TBListDetailComponent class >> defaultViewStyle [

	^#table
]

{ #category : #actions }
TBListDetailComponent >> add [

	self root 
		show: (self validatedFormOn: (self selected new))
		onAnswer: [ :result |
			result isNil
				ifFalse: [
					self value: (self value copyWith: result).
					self parent save.
					self session presenter saveObject: self parent model.
					self refresh ] ]

]

{ #category : #private }
TBListDetailComponent >> attributeDescriptions [

	^self reference children select: [:each | each isVisible]

]

{ #category : #private }
TBListDetailComponent >> buildChipView [

	^(TBChipView rows: self value description: self reference)
		parent: self;
		removeBlock: [:arg | self remove: arg ];
		sortEnabled: self magritteDescription isOrdered not;
		flushTop: true;
		yourself
]

{ #category : #private }
TBListDetailComponent >> buildGridView [

	^(TBGridView rows: self value description: self reference)
		parent: self;
		removeBlock: [:arg | self remove: arg ];
		sortEnabled: self magritteDescription isOrdered not;
		flushTop: true;
		yourself
]

{ #category : #private }
TBListDetailComponent >> buildMagritteReport [

	^ (TBTableView
		rows: self value
		description: self reference)
		sortEnabled: self magritteDescription isOrdered not;
		addColumn: (MACommandColumn new
			addCommandOn: self selector: #edit: text: 'edit';
			addCommandOn: self selector: #remove: text: 'remove';
			yourself);
		yourself
]

{ #category : #private }
TBListDetailComponent >> buildMdlListReport [

	^(TBListView rows: self value description: self reference)
		parent: self;
		removeBlock: [:arg | self remove: arg ];
		sortEnabled: self magritteDescription isOrdered not;
		flushTop: true;
		yourself
]

{ #category : #private }
TBListDetailComponent >> buildMdlTableReport [

	^TBMdlSortableTable new
		parent: self;
		attributeDescriptions: self attributeDescriptions;
		"title: self magritteDescription label;"
		title: self memento model mdlDisplayString;
		"selectable: true;"
		header: (self attributeDescriptions collect: [:each | each label]);
		rows: self value;
		rowsPerPagePossibilities: #(6 25 50 100 200).

]

{ #category : #private }
TBListDetailComponent >> buildReport [

	"self viewStyle = #list ifTrue: [^self buildMdlListReport]."
	self viewStyle = #table ifTrue: [^self buildMdlTableReport].
	self viewStyle = #grid ifTrue: [^self buildGridView].
	self viewStyle = #chip ifTrue: [^self buildChipView].

	^self buildMdlListReport

]

{ #category : #actions }
TBListDetailComponent >> cancel [

	self answer: nil
]

{ #category : #accessing }
TBListDetailComponent >> detailComponent [
	^ detailComponent
]

{ #category : #accessing }
TBListDetailComponent >> detailComponent: anObject [
	detailComponent := anObject
]

{ #category : #actions }
TBListDetailComponent >> primaryActionOn: aModel [

	"self session presenter addToRecent: aModel"
	self root show: (aModel asComponent addValidatedForm; yourself)

	"| component modelDescription |

	modelDescription := aModel magritteDescription.
	component := (modelDescription select: [:each | each viewStructure not]) asComponentOn: aModel.

	self detailComponent: component"
]

{ #category : #actions }
TBListDetailComponent >> refresh [

	^super refresh.

]

{ #category : #actions }
TBListDetailComponent >> remove: anObject [

	self value: (self value copyWithout: anObject).
	self parent save.
	self refresh
]

{ #category : #rendering }
TBListDetailComponent >> renderEditorOn: html [

	html mdlGrid class: 'mdl-grid--no-spacing'; with: [ 
		self renderLabelOn: html.

		html mdlCell size: 12; with: [
			self renderReportOn: html ] ]
]

{ #category : #rendering }
TBListDetailComponent >> renderLabelOn: html [

	html mdlCell size: 12; with: [
		html mdlTextFieldContainer floatingLabel; style: 'padding-bottom: 0px'; with: [
			html mdlTextFieldInput
				attributeAt: 'hidden' put: 'true'; style: 'height: 0px';
				id: self labelId; type: 'text'; value: ' '.
			html mdlTextFieldLabel
				for: self labelId; with: self magritteDescription label ] ].

]

{ #category : #rendering }
TBListDetailComponent >> renderReportOn: html [

	html render: self report.

]

{ #category : #'rendering-buttons' }
TBListDetailComponent >> renderSelectButtonOn: html [
	"Do nothing - add button is rendered by table widget"
	"super renderSelectButtonOn: html"

	"html mdlButton
		raised; colored;
		value: 'Add';
		onClick: ((html jQuery ajax)
			callback: [ self add ];
			onComplete: html javascript refresh);
		yourself."

]

{ #category : #'rendering-buttons' }
TBListDetailComponent >> renderSelectListOn: html [
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

]

{ #category : #rendering }
TBListDetailComponent >> renderViewerOn: html [

	html mdlGrid class: 'mdl-grid--no-spacing'; with: [ 
		self renderLabelOn: html.

		html mdlCell size: 12; with: [
			self renderReportOn: html ] ]
]

{ #category : #actions }
TBListDetailComponent >> resetReport [

	report := nil
]

{ #category : #accessing }
TBListDetailComponent >> selected: aClass [

	^super selected: aClass
]

{ #category : #accessing }
TBListDetailComponent >> viewStyle [

	viewStyle isNil ifTrue: [ self viewStyle: self class defaultViewStyle ].

	^ viewStyle
]

{ #category : #accessing }
TBListDetailComponent >> viewStyle: anObject [
	viewStyle := anObject
]

{ #category : #accessing }
TBListDetailComponent >> viewStyleBeChip [

	self viewStyle: #chip.
	self resetReport.

]

{ #category : #accessing }
TBListDetailComponent >> viewStyleBeDefault [

	self viewStyle: self class defaultViewStyle.
	self resetReport.

]

{ #category : #accessing }
TBListDetailComponent >> viewStyleBeGrid [

	self viewStyle: #grid.
	self resetReport.

]

{ #category : #accessing }
TBListDetailComponent >> viewStyleBeList [

	self viewStyle: #list.
	self resetReport.

]

{ #category : #accessing }
TBListDetailComponent >> viewStyleBeTable [

	self viewStyle: #table.
	self resetReport.

]

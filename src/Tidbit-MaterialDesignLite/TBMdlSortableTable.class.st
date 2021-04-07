Class {
	#name : #TBMdlSortableTable,
	#superclass : #MDLSortableTable,
	#instVars : [
		'parent',
		'attributeDescriptions'
	],
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #accessing }
TBMdlSortableTable >> attributeDescriptions [
	^ attributeDescriptions
]

{ #category : #accessing }
TBMdlSortableTable >> attributeDescriptions: anObject [
	attributeDescriptions := anObject
]

{ #category : #accessing }
TBMdlSortableTable >> parent [
	^ parent
]

{ #category : #accessing }
TBMdlSortableTable >> parent: anObject [
	parent := anObject
]

{ #category : #rendering }
TBMdlSortableTable >> renderAddButtonOn: html [

	html mdlButton
		"raised; colored;"
		value: 'Add';
		"callback: [ self parent add ];"
		onClick: ((html jQuery ajax)
			callback: [ self parent add ];
			onComplete: html javascript refresh);
		yourself.

]

{ #category : #rendering }
TBMdlSortableTable >> renderCardTitleOn: html [

	html mdlCardTitle
		style: 'padding-left: 24px;';
		with: [
			"self title ifNotNil: [ html mdlCardTitleText: self title level: 2 ]."
			html mdlLayoutSpacer.
			self renderSelectListOn: html.
			"self renderMenuOn: html withId: 'buttonId'" ].

]

{ #category : #rendering }
TBMdlSortableTable >> renderContentOn: html [

	html mdlCard
		"shadow: 2;"
		style: 'overflow-x: auto; width: 100%;';
		id: (id := html nextId);
		with: [
			self renderTableContentOn: html ]

]

{ #category : #rendering }
TBMdlSortableTable >> renderFooterPaginationOn: html [
	html
		mdlCardTextContainer: [ 
			html div
				"mdlTypographyTextRight;"
				with: [ 
							html text: 'Rows per page: '.
							html render: self itemsByPageSelectionComponent.
							self renderPagesInfoOn: html.
							self
								renderButtonTriggering: #previousPosition
								withIcon: #keyboard_arrow_left
								disabled: position = 1
								on: html.
							self
								renderButtonTriggering: #nextPosition
								withIcon: #keyboard_arrow_right
								disabled: position + elementsToShow > self rows size
								on: html ] ]
]

{ #category : #rendering }
TBMdlSortableTable >> renderMenuOn: html withId: buttonId [

	html mdlMenu
		topLeft;
		for: 'menuButton' , buttonId;
		class: 'menuButtonWidgetMenu';
		with: [
			self objectsPossibilitiesWithLabel do: [ :anAssociation |
				self renderMenuItemOn: html withAssociation: anAssociation ] ]
]

{ #category : #rendering }
TBMdlSortableTable >> renderRowsOn: html [
	| instanceSubset |

	instanceSubset := (position to: (self rows size min: position + elementsToShow)) collect: [ :rowIndex | self rows at: rowIndex ].

	instanceSubset
		do: [ :each | | cells |
			cells := self attributeDescriptions collect: [:eachAttribute | eachAttribute displayStringFor: (each readUsing: eachAttribute) ].
			html tableRow
				onClick: ((html jQuery ajax)
						callback: [ self parent primaryActionOn: each ];
						onComplete: html javascript refresh);
				with: [ self renderRowContentFor: cells on: html ] ]
]

{ #category : #rendering }
TBMdlSortableTable >> renderSelectListOn: html [
	| selectTag selectId |

	self parent classes size > 1 ifTrue: [
		selectTag := html select.
		selectTag
			id: (selectId := html nextId);
			list: self parent classes;
			selected: self parent selected;
			"callback: [ :value | self parent selected: value ];"
			callback: [ :value | "values map is not built unless there is a callback"];
			onChange: (html jQuery ajax
				callback: [ :value |
					self parent selected: ((selectTag instVarNamed: 'values') at: value greaseInteger) ]
					value: (html jQuery id: selectId) value;
				yourself
				"script: [ :s | s alert: 'The submitted value is: ' , self parent selected printString, '.' ]");
			labels: [ :value | value label ] ].

	self parent classes notEmpty
		ifTrue: [ self renderAddButtonOn: html ]

]

{ #category : #rendering }
TBMdlSortableTable >> renderTableContentOn: html [

	rowsCache := self rows.
	self ensureCurrentPageIsVisible.

	self renderCardTitleOn: html.

	(selectable
		ifTrue: [ html mdlTable selectable ]
		ifFalse: [ html mdlTable ])
			style: 'width: 100%; border: none';
			with: [ 
					self renderHeaderOn: html.
					self renderRowsOn: html ].

	self renderFooterPaginationOn: html
]

{ #category : #sorting }
TBMdlSortableTable >> sortAtRow: aRowIndex using: aSelector [
	| attributeDescription |

	header do: [ :each | 
		(header at: aRowIndex) = each ifFalse: [ each unsort ] ].

	attributeDescription := self attributeDescriptions at: aRowIndex.
	rows := self rows
		sorted: [ :cell :anotherCell | | a b |
			a := cell readUsing: attributeDescription.
			b := anotherCell readUsing: attributeDescription.
			[ a perform: aSelector with: b ]
				on: MessageNotUnderstood "If the element does not implements the comparators then I should not sort them."
				do: [ true ]	 ]
]

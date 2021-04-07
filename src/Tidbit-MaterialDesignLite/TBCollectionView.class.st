Class {
	#name : #TBCollectionView,
	#superclass : #MAReport,
	#instVars : [
		'parent',
		'editBlock',
		'removeBlock',
		'flushTop',
		'showAddButton'
	],
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #actions }
TBCollectionView >> buildEditorFor: anObject titled: aString [

	^ anObject asComponent
		addValidatedForm;
		addMessage: aString;
		yourself
]

{ #category : #actions }
TBCollectionView >> buildViewerFor: anObject titled: aString [

	^ anObject asComponent
		addSwitch;
		addMessage: aString;
		yourself
]

{ #category : #accessing }
TBCollectionView >> editBlock [
	^ editBlock
]

{ #category : #accessing }
TBCollectionView >> editBlock: anObject [
	editBlock := anObject
]

{ #category : #actions }
TBCollectionView >> editInstance: aModelInstance [

	self
		show: (self
			buildEditorFor: aModelInstance
			titled: 'Edit ' , aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
]

{ #category : #accessing }
TBCollectionView >> flushTop [
	^ flushTop
]

{ #category : #accessing }
TBCollectionView >> flushTop: anObject [
	flushTop := anObject
]

{ #category : #initialize }
TBCollectionView >> initialize [

	super initialize.

	self flushTop: false.
	self showAddButton: true.

]

{ #category : #accessing }
TBCollectionView >> parent [
	^ parent
]

{ #category : #accessing }
TBCollectionView >> parent: anObject [
	parent := anObject
]

{ #category : #actions }
TBCollectionView >> refresh [

	super refresh.
	"self cache: nil; batchPage: self defaultBatchPage."

]

{ #category : #accessing }
TBCollectionView >> removeBlock [
	^ removeBlock
]

{ #category : #accessing }
TBCollectionView >> removeBlock: anObject [
	removeBlock := anObject
]

{ #category : #actions }
TBCollectionView >> removeInstance: aModelInstance [

	self parent remove: aModelInstance.

]

{ #category : #rendering }
TBCollectionView >> renderAddButtonOn: html [

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
TBCollectionView >> renderBatchNextOn: html [

	self isOnLastPage
		ifFalse: [ html anchor callback: [ self nextPage ]; with: [html mdlIcon: #keyboard_arrow_right] ]
		ifTrue: [ html mdlIcon: #keyboard_arrow_right ].

]

{ #category : #rendering }
TBCollectionView >> renderBatchPreviousOn: html [

	self isOnFirstPage
		ifFalse: [ html anchor callback: [ self previousPage ]; with: [html mdlIcon: #keyboard_arrow_left] ]
		ifTrue: [ html mdlIcon: #keyboard_arrow_left ].
	html space

]

{ #category : #rendering }
TBCollectionView >> renderCardTitleOn: html [
	| cardTitle |

	cardTitle := html mdlCardTitle.
	self flushTop
		ifTrue: [ cardTitle style: 'padding-bottom: 0px;' ].

	cardTitle
		"style: 'padding-left: 24px;';"
		with: [
			"self title ifNotNil: [ html mdlCardTitleText: self title level: 2 ]."
			((self showBatch and: [ self hasMoreThanOnePage ]) or: [ self showFooter ])
				ifTrue: [
					html mdlCardActions with: [
						self showFooter
							ifTrue: [ self renderTableFootOn: html ].
						self showBatch
							ifTrue: [ self renderTableBatchOn: html ] ] ].
			html mdlLayoutSpacer.
			self showAddButton ifTrue: [self renderSelectListOn: html] ].

]

{ #category : #rendering }
TBCollectionView >> renderContentOn: html [

	html mdlCard
		"style: 'margin: 0';"
		"shadow: 2;"
		style: 'overflow-x: auto; width: 100%;';
		with: [
			self renderListOn: html.
			self renderCardTitleOn: html.
		]

]

{ #category : #rendering }
TBCollectionView >> renderFooterPaginationOn: html [

	html
		mdlCardTextContainer: [ 
			html div
				mdlTypographyTextRight;
				with: [ 
							"html text: 'Rows per page: '.
							html render: self itemsByPageSelectionComponent.
							self renderPagesInfoOn: html."
							self
								renderButtonTriggering: #previousPosition
								withIcon: #keyboard_arrow_left
								disabled: false "position = 1"
								on: html.
							self
								renderButtonTriggering: #nextPosition
								withIcon: #keyboard_arrow_right
								disabled: false "position + elementsToShow > self rows size"
								on: html ] ]
]

{ #category : #rendering }
TBCollectionView >> renderListOn: html [

	self subclassResponsibility

]

{ #category : #rendering }
TBCollectionView >> renderSelectListOn: html [
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
TBCollectionView >> renderTableBatchOn: html [
	self hasMoreThanOnePage ifTrue: [
					self showBatchFirstLast
						ifTrue: [ self renderBatchFirstOn: html ].
					self showBatchPreviousNext
						ifTrue: [ self renderBatchPreviousOn: html ].
					self showBatchPages
						ifTrue: [ self renderBatchItemsOn: html ].
					self showBatchPreviousNext
						ifTrue: [ self renderBatchNextOn: html ].
					self showBatchFirstLast
						ifTrue: [ self renderBatchLastOn: html ] ]
]

{ #category : #accessing }
TBCollectionView >> showAddButton [
	^ showAddButton
]

{ #category : #accessing }
TBCollectionView >> showAddButton: anObject [
	showAddButton := anObject
]

{ #category : #actions }
TBCollectionView >> viewInstance: aModelInstance [

	self session inspect.

	self
		show: (self
			buildViewerFor: aModelInstance
			titled: aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
]

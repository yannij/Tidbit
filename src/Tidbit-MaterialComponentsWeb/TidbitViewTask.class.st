Class {
	#name : #TidbitViewTask,
	#superclass : #MCWWebComponent,
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #rendering }
TidbitViewTask >> dataRows [

	^ self tasksFiltered asOrderedCollection collect: [ :eachTask |
		| dataRow |
		dataRow := OrderedCollection new.
		dataRow add: (eachTask done ifTrue: [ [ :html | html span mdcMaterialIcons; with: 'check' ] ] ifFalse: [ '' ]).
		dataRow add: (eachTask summary ifNotNil: [ :value | value ] ifNil: [ '' ]).
		dataRow add: eachTask completeBy.
		dataRow add: eachTask estimatedDuration humanReadablePrintString.
		dataRow add: eachTask importance greaseString.
		dataRow add: eachTask priority greaseString.
		"dataRow add: eachTask colorCode shortPrintString."
		dataRow add: [ :html | html textInput type: 'color'; disabled; value: eachTask colorCode asHTMLColor ].
		dataRow add: (eachTask description ifNotNil: [ :value | value truncateWithElipsisTo: 25 ] ifNil: [ '' ]).
		dataRow ]
]

{ #category : #rendering }
TidbitViewTask >> renderContentOn: html [

	self renderTableOn: html
]

{ #category : #rendering }
TidbitViewTask >> renderTableHeadingsOn: html [
	| dataHeadings |

	dataHeadings := #( 'Done' 'Summary' 'Complete By' 'Duration' 'Importance' 'Priority' 'Color Code' 'Description' ).
	html tableHead: [
		html tableRow "mdcDataTable__headerRow" class: 'mdc-data-table__header-row'; with: [
			dataHeadings do: [ :each |
				html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each ] ] ]

]

{ #category : #rendering }
TidbitViewTask >> renderTableOn: html [

	html heading level6; mdcTypography_headline6; with: self sessionUserGet mdPrimaryString.
	html div mdcDataTable with: [
		html div mdcDataTable__tableContainer; with: [
			| dataRows |
			dataRows := self dataRows.
			html table mdcDataTable__table;  with: [
				self renderTableHeadingsOn: html.
				self renderTableRows: dataRows on: html ].
		self renderTableRows: dataRows paginationOn: html ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderTableRows: dataRows on: html [

	html tableBody mdcDataTable__content; with: [
		dataRows do: [ :eachRow |
			html tableRow mdcDataTable__row; with: [
				eachRow keysAndValuesDo: [ :index :each |
					html tableData mdcDataTable__cell; scope: 'row'; with: each ] ] ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderTableRows: dataRows paginationOn: html [

	html div mdcDataTable__pagination with: [
		html div mdcDataTable__paginationTrailing; with: [
			"html div mdcDataTable__paginationRowsPerPage; with: [
				html div mdcDataTable__paginationRowsPerPageLabel; with: [
					html text: 'Rows per page' ] ].
				html div x; with: []".
			html div mdcDataTable__paginationNavigation; with: [
				html div mdcDataTable__paginationTotal; with: [ html text: '1-', dataRows size printString, ' of ', dataRows size printString ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-first-page' put: 'true'; disabled;
					with: [ html div mdcButton__icon; with: 'first_page' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-prev-page' put: 'true'; disabled;
					with: [ html div mdcButton__icon; with: 'chevron_left' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-next-page' put: 'true';
					with: [ html div mdcButton__icon; with: 'chevron_right' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-last-page' put: 'true';
					with: [ html div mdcButton__icon; with: 'last_page' ] ] ] ]
]

{ #category : #accessing }
TidbitViewTask >> sessionUserGet [

	^ self session properties at: #authenticatedUser ifAbsent: [ nil ]
]

{ #category : #rendering }
TidbitViewTask >> tasksFiltered [
	| user tasksFilterDone tasksAll |

	user := self sessionUserGet.	
	user ifNil: [ ^ #() ].

	tasksAll := user toDoItems.
	tasksFilterDone := self applicationRootGet viewTaskFilter filterDone.

	tasksFilterDone = 'doneOnly'
		ifTrue: [ ^ tasksAll select: [ :eachTask | eachTask done ] ].

	tasksFilterDone = 'notDoneOnly'
		ifTrue: [ ^ tasksAll reject: [ :eachTask | eachTask done ] ].

	^ tasksAll
]
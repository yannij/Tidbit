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
TidbitViewTask >> renderCards: aUser on: html [

	html div mdcLayoutGrid; with: [
		html div mdcLayoutGrid__inner; with: [
			self tasksFiltered do: [ :eachItem |
				html div mdcLayoutGrid__cell with: [
					html div mdcCard; with: [
						html div mdcCard__media; class: 'mdc-card__media--16-9';
							style: 'background: #', eachItem colorCode asHexString; with: [
								html div mdcCard__mediaContent; with: [
									html heading level2; mdcTypography_headline6;
										style: 'text-align: center; margin-top: 0px; background: white; opacity: .5';
										with: eachItem summary ] ].
						html div mdcCard__primaryAction; style: 'padding: 4px'; with: [
							html heading level3; mdcTypography_subtitle2; with: eachItem mdDisplaySecondaryString.
							html div mdcTypography_body2; with: eachItem description ] ] ] ] ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderChips: aUser on: html [
	| iconMap |

	iconMap := Dictionary new at: 'High' put: 'star'; at: 'Medium' put: 'star_half'; at: 'Low' put: 'star_outline'; yourself.

	html unorderedList mdcList; mdcList_dense;
		"style: 'min-width: 400px';"
		with: [
			self tasksFiltered
				do: [ :eachItem |
					html div mdcChip; mdcRippleUpgraded;
						style: 'background: #', eachItem colorCode asHexString;
						with: [
							html span mdcMaterialIcons; mdcChip__icon; mdcChip__icon_leading;
								with: (iconMap at: eachItem importance ifAbsent: [ 'star' ]).
							html span mdcChip__text; with: [
								html text: eachItem mdPrimaryString ] ] ]
				separatedBy: [ html space ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderContentOn: html [
	| user itemsStyle |

	user := self mcwApplicationGet viewUserModel.	
	user ifNil: [ ^ self ].

	html heading level6; mdcTypography_headline6; style: 'margin: 4px auto'; with: user mdPrimaryString.

	itemsStyle := self mcwApplicationGet viewTaskFilter itemsStyle.

	itemsStyle = #listSingleLine ifTrue: [
		^ self renderListSingleLine: user on: html ].

	itemsStyle = #listTwoLine ifTrue: [
		^ self renderListTwoLine: user on: html ].

	itemsStyle = #chips ifTrue: [
		^ self renderChips: user on: html ].

	itemsStyle = #cards ifTrue: [
		^ self renderCards: user on: html ].

	self renderTable: user on: html
]

{ #category : #rendering }
TidbitViewTask >> renderListSingleLine: aUser on: html [

	html unorderedList mdcList; mdcList_dense;
		"style: 'min-width: 400px';"
		with: [
			self tasksFiltered do: [ :eachItem |
				html listItem mdcListItem; with: [
					html span mdcListItem__text; with:
						((eachItem mdPrimaryString , ' - ' , eachItem mdDisplaySecondaryString)
							truncateWithElipsisTo: 60) ] ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderListTwoLine: aUser on: html [
	| filteredList listHigh listMedium listLow |

	filteredList := self tasksFiltered.

	listHigh := filteredList select: [ :each | each importance = 'High' ].
	listMedium := filteredList select: [ :each | each importance = 'Medium' ].
	listLow := filteredList select: [ :each | each importance = 'Low' ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'High'.
		html unorderedList mdcList; mdcList_twoLine; with: [
			self renderListTwoLineItems: listHigh on: html ] ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'Medium'.
		html unorderedList mdcList; mdcList_twoLine; with: [
			self renderListTwoLineItems: listMedium on: html ] ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'Low'.
		html unorderedList mdcList; mdcList_twoLine; with: [
			self renderListTwoLineItems: listLow on: html ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderListTwoLineItems: anItemList on: html [

	anItemList isEmpty ifTrue: [
		html listItem mdcListItem; with: [
			html span mdcListItem__text; with: [
				html span mdcListItem__secondaryText; with: '** NONE **' ] ].
		^ self ].

	anItemList do: [ :eachItem |
		html listItem mdcListItem; with: [
			html span mdcListItem__text; with: [
				html span mdcListItem__primaryText; with:
					eachItem mdPrimaryString.
				html span mdcListItem__secondaryText; with:
					(eachItem mdDisplaySecondaryString truncateWithElipsisTo: 60) ] ] ]
]

{ #category : #rendering }
TidbitViewTask >> renderTable: aUser on: html [

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
TidbitViewTask >> renderTableHeadingsOn: html [
	| dataHeadings |

	dataHeadings := #( 'Done' 'Summary' 'Complete By' 'Duration' 'Importance' 'Priority' 'Color Code' 'Description' ).
	html tableHead: [
		html tableRow "mdcDataTable__headerRow" class: 'mdc-data-table__header-row'; with: [
			dataHeadings do: [ :each |
				html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each ] ] ]

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

{ #category : #rendering }
TidbitViewTask >> tasksFiltered [
	| user tasksFilterDone tasksAll |

	user := self mcwApplicationGet viewUserModel.	
	user ifNil: [ ^ #() ].

	tasksAll := user toDoItems.
	tasksFilterDone := self mcwApplicationGet viewTaskFilter filterDone.

	tasksFilterDone = #doneOnly
		ifTrue: [ ^ tasksAll select: [ :eachTask | eachTask done ] ].

	tasksFilterDone = #notDoneOnly
		ifTrue: [ ^ tasksAll reject: [ :eachTask | eachTask done ] ].

	^ tasksAll
]

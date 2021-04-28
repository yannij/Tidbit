Class {
	#name : #TidbitViewTask,
	#superclass : #MCWWebComponent,
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
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

{ #category : #accessing }
TidbitViewTask >> denseView [

	^ self mcwApplicationGet denseView
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderCards: aUser on: html [
	| list selected |

	selected := self sideSheet tabImportanceSelected.
	list := self tasksFiltered select: [ :each | each importance = selected ].

	self renderCardsTabsOn: html.

	html div mdcLayoutGrid; id: nil; with: [
		html div mdcLayoutGrid__inner; with: [
			self renderCardsItems: list on: html ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderCardsItems: anItemList on: html [

	anItemList do: [ :eachItem |
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
					html div mdcTypography_body2; with: eachItem description ] ] ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderCardsTabsOn: html [

	html div mdcTabBar; mdcAutoInit: 'MDCTabBar'; with: [
		html div mdcTabScroller; "mdcAutoInit: 'MDCTabScroller';" with: [
			html div mdcTabScroller__scrollArea; mdcTabScroller__scrollArea_scroll; with: [
				TidbitToDoItem importanceValues withIndexDo: [ :eachValue :index |
					html div mdcTabScroller__scrollContent; with: [
						| tagTab tagTabId tagTabIndicator tagTabIndicatorId |
						(tagTab := html anchor) mdcTab; "mdcAutoInit: 'MDCTab';"
							id: (tagTabId := html nextId);
							callback: [ self sideSheet tabImportance: eachValue ];
							with: [
									html span mdcTab__content; with: [
									html span mdcTab__textLabel; with: eachValue ].
									(tagTabIndicator := html span)
										mdcTabIndicator;
										id: (tagTabIndicatorId := html nextId);
										with: [
											html span mdcTabIndicator__content; mdcTabIndicator__content_underline ].
								html span mdcTab__ripple; mdcRippleUpgraded ].
						eachValue = self sideSheet tabImportance ifTrue: [
							html script: (html jQuery script: [ :s | s
									<< ((s jQuery id: tagTab id) call: 'focus');
									<< ((s jQuery id: tagTabIndicator id) call: 'addClass' with: 'mdc-tab-indicator--active') ])
							"tagTab mdcTab_active.
							tagTabIndicator mdcTabIndicator_active" ] ] ] ] ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderChips: aUser on: html [
	| iconMap |

	iconMap := Dictionary new
		at: TidbitToDoItem importanceValueHigh put: 'star';
		at: TidbitToDoItem importanceValueMedium put: 'star_half';
		at: TidbitToDoItem importanceValueLow put: 'star_outline';
		yourself.

	html unorderedList mdcList; mdcList_dense_if: self denseView;
		"style: 'min-width: 400px';"
		with: [
			self tasksFiltered
				do: [ :eachItem |
					html div mdcChip; mdcRippleUpgraded;
						"style: 'margin: 0px 4px 8px 0px';"
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
	| user heading |

	user := self mcwApplicationGet viewUserModel.	
	user ifNil: [ ^ self ].

	heading := user mdPrimaryString.
	self sideSheet filterDone ifNotNil: [ :value |
		value = #both ifTrue: [ heading := heading, ' - All tasks' ].
		value = #doneOnly ifTrue: [ heading := heading, ' - Done tasks' ].
		value = #notDoneOnly ifTrue: [ heading := heading, ' - Not done tasks' ] ].

	html heading level6; mdcTypography_headline6; style: 'margin: 4px auto'; with: heading.

	self renderStyledItemsFor: user on: html
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderListSingleLine: aUser on: html [

	html unorderedList
		mdcList;
		mdcList_dense_if: self denseView;
		mdcTheme_surface;
		"style: 'min-width: 400px';"
		with: [
			self tasksFiltered do: [ :eachItem |
				html listItem mdcListItem; with: [
					html span mdcListItem__text; with:
						((eachItem mdPrimaryString , ' - ' , eachItem mdDisplaySecondaryString)
							truncateWithElipsisTo: 60) ] ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderListTwoLine: aUser on: html [
	| filteredList listHigh listMedium listLow |

	filteredList := self tasksFiltered.

	listHigh := filteredList select: [ :each | each importanceIsHigh ].
	listMedium := filteredList select: [ :each | each importanceIsMedium ].
	listLow := filteredList select: [ :each | each importanceIsLow ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'High'.
		html unorderedList mdcList; mdcList_twoLine; mdcList_dense_if: self denseView; with: [
			self renderListTwoLineItems: listHigh on: html ] ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'Medium'.
		html unorderedList mdcList; mdcList_twoLine; mdcList_dense_if: self denseView; with: [
			self renderListTwoLineItems: listMedium on: html ] ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'Low'.
		html unorderedList mdcList; mdcList_twoLine; mdcList_dense_if: self denseView; with: [
			self renderListTwoLineItems: listLow on: html ] ]
]

{ #category : #'rendering - styles' }
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
TidbitViewTask >> renderStyledItemsFor: user on: html [
	| itemsStyle |

	itemsStyle := self sideSheet itemsStyle.

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

{ #category : #'rendering - styles' }
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

{ #category : #'rendering - styles' }
TidbitViewTask >> renderTableHeadingsOn: html [
	| dataHeadings |

	dataHeadings := #( 'Done' 'Summary' 'Complete By' 'Duration' 'Importance' 'Priority' 'Color Code' 'Description' ).
	html tableHead: [
		html tableRow "mdcDataTable__headerRow" class: 'mdc-data-table__header-row'; with: [
			dataHeadings do: [ :each |
				html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each ] ] ]

]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderTableRows: dataRows on: html [

	html tableBody mdcDataTable__content; with: [
		dataRows do: [ :eachRow |
			html tableRow mdcDataTable__row; with: [
				eachRow keysAndValuesDo: [ :index :each |
					html tableData mdcDataTable__cell; scope: 'row'; with: each ] ] ] ]
]

{ #category : #'rendering - styles' }
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
TidbitViewTask >> sideSheet [

	^ self mcwApplicationGet viewTaskFilter
]

{ #category : #accessing }
TidbitViewTask >> tasksFiltered [
	| user tasksFilterDone tasksAll |

	user := self mcwApplicationGet viewUserModel.	
	user ifNil: [ ^ #() ].

	tasksAll := user toDoItems.
	tasksFilterDone := self sideSheet filterDone.

	tasksFilterDone = #doneOnly
		ifTrue: [ ^ tasksAll select: [ :eachTask | eachTask done ] ].

	tasksFilterDone = #notDoneOnly
		ifTrue: [ ^ tasksAll reject: [ :eachTask | eachTask done ] ].

	^ tasksAll
]

Class {
	#name : #TidbitViewTask,
	#superclass : #MCWLayoutComponent,
	#instVars : [
		'report'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
TidbitViewTask >> buildReport [

	^ (MCWReport rows: self tasksFiltered description: TidbitToDoItem magritteTemplate magritteDescription)
		showHeader: true;
		showFooter: true;
		addColumn: (MCWActionColumn new
			commandBlock: (MessageSend receiver: self selector: #navTo:);
			yourself);
		yourself
]

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

	^ self layout app denseView
]

{ #category : #rendering }
TidbitViewTask >> navTo: aModel [

	self mcwApplicationGet navTo: aModel
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderCards: aUser on: html [
	| list selected |

	selected := self sideSheet tabImportanceSelected.
	list := self tasksFiltered select: [ :each | each importance = selected ].

	self renderCardsTabsOn: html.

	html div mdcLayoutGrid; style: 'padding-left: 0px; padding-right: 0px'; with: [
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
				html div mdcCard__primaryAction; style: 'padding: 4px';
					onClick: ((html jQuery ajax)
						callback: [ self mcwApplicationGet navTo: eachItem ];
						onComplete: html javascript refresh);
					with: [
						html heading level3; mdcTypography_subtitle2; with: eachItem mdSecondaryString.
						html div mdcTypography_body2; with: eachItem description ] ] ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderCardsTabsOn: html [

	html div mdcTabBar; mdcAutoInit: 'MDCTabBar'; with: [
		html div mdcTabScroller; "mdcAutoInit: 'MDCTabScroller';" with: [
			html div mdcTabScroller__scrollArea; mdcTabScroller__scrollArea_scroll; with: [
				TidbitToDoItem importanceValues withIndexDo: [ :eachValue :index |
					html div mdcTabScroller__scrollContent; with: [
						| tagTab tagTabIndicator |
						(tagTab := html anchor) mdcTab; "mdcAutoInit: 'MDCTab';"
							id: html nextId;
							callback: [ self sideSheet tabImportance: eachValue ];
							with: [
									html span mdcTab__content; with: [
									html span mdcTab__textLabel; with: eachValue ].
									(tagTabIndicator := html span)
										mdcTabIndicator;
										id: html nextId;
										with: [
											html span mdcTabIndicator__content; mdcTabIndicator__content_underline ].
								html span mdcTab__ripple; mdcRippleUpgraded ].
						eachValue = self sideSheet tabImportance ifTrue: [
							html script: (html jQuery script: [ :s | s
									<< ((s jQuery id: tagTab id) call: 'focus');
									<< ((s jQuery id: tagTabIndicator id) call: 'addClass' with: 'mdc-tab-indicator--active') ]) ] ] ] ] ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderChips: aUser on: html [
	| iconMap |

	iconMap := Dictionary new
		at: TidbitToDoItem importanceValueHigh put: 'star';
		at: TidbitToDoItem importanceValueMedium put: 'star_half';
		at: TidbitToDoItem importanceValueLow put: 'star_outline';
		yourself.

	html unorderedList mdcDeprecatedList; mdcList_dense_if: self denseView;
		"style: 'min-width: 400px';"
		with: [
			self tasksFiltered
				do: [ :eachItem |
					html div mdcChip; mdcRippleUpgraded;
						"style: 'margin: 0px 4px 8px 0px';"
						style: 'background: #', eachItem colorCode asHexString;
						onClick: ((html jQuery ajax)
							callback: [ self mcwApplicationGet navTo: eachItem ];
							onComplete: html javascript refresh);
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

	user := self layout app viewUserModel.	
	user ifNil: [ ^ self ].

	heading := user mdPrimaryString.
	self sideSheet filterDone ifNotNil: [ :value |
		value = #both ifTrue: [ heading := heading, ' - All tasks' ].
		value = #doneOnly ifTrue: [ heading := heading, ' - Done tasks' ].
		value = #notDoneOnly ifTrue: [ heading := heading, ' - Not done tasks' ] ].

	html div style: 'padding: 8px';
		"mdcStyle: self layout contentAreaWidthCalc if: self layout sideSheetVisible;"
		"style: 'max-width: 960px';
		style: 'width: 960px';"
		with: [
		"html heading level6; mdcTypography_headline6; style: 'margin: 4px auto'; with: heading."
		html heading level3; mdcTypography_subtitle1; with: heading.
		self renderStyledItemsFor: user on: html ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderListSingleLine: aUser on: html [

	html unorderedList
		mdcDeprecatedList;
		mdcList_dense_if: self denseView;
		mdcTheme_surface;
		"style: 'min-width: 400px';"
		with: [
			self tasksFiltered do: [ :eachItem |
				html listItem
					mdcDeprecatedListItem;
					onClick: ((html jQuery ajax)
						callback: [ self mcwApplicationGet navTo: eachItem ];
						onComplete: html javascript refresh);
					with: [
						html span mdcDeprecatedListItem__text; with:
							((eachItem mdPrimaryString , ' - ' , eachItem mdSecondaryString)
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
		html unorderedList mdcDeprecatedList; mdcDeprecatedList_twoLine; mdcList_dense_if: self denseView; with: [
			self renderListTwoLineItems: listHigh on: html ] ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'Medium'.
		html unorderedList mdcDeprecatedList; mdcDeprecatedList_twoLine; mdcList_dense_if: self denseView; with: [
			self renderListTwoLineItems: listMedium on: html ] ].

	html div mdcListGroup; mdcTheme_surface; with: [
		html div mdcListGroup__subheader; with: 'Low'.
		html unorderedList mdcDeprecatedList; mdcDeprecatedList_twoLine; mdcList_dense_if: self denseView; with: [
			self renderListTwoLineItems: listLow on: html ] ]
]

{ #category : #'rendering - styles' }
TidbitViewTask >> renderListTwoLineItems: anItemList on: html [

	anItemList isEmpty ifTrue: [
		html listItem mdcDeprecatedListItem; with: [
			html span mdcDeprecatedListItem__text; with: [
				html span mdcListItem__secondaryText; with: '** NONE **' ] ].
		^ self ].

	anItemList do: [ :eachItem |
		html listItem
			mdcDeprecatedListItem;
			onClick: ((html jQuery ajax)
				callback: [ self mcwApplicationGet navTo: eachItem ];
				onComplete: html javascript refresh);
			with: [
				html span mdcDeprecatedListItem__text; with: [
					html span mdcListItem__primaryText; with:
						eachItem mdPrimaryString.
					html span mdcListItem__secondaryText; with:
						(eachItem mdSecondaryString truncateWithElipsisTo: 60) ] ] ]
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

	self report ifNil: [ self report: self buildReport ].
	html div style: 'overflow-x: scroll;'; with: [
		html render: self report ]
]

{ #category : #accessing }
TidbitViewTask >> report [
	^ report
]

{ #category : #accessing }
TidbitViewTask >> report: anObject [
	report := anObject
]

{ #category : #accessing }
TidbitViewTask >> sideSheet [

	^ self layout app viewTaskFilter
]

{ #category : #accessing }
TidbitViewTask >> tasksFiltered [
	| user tasksFilterDone tasksAll |

	user := self layout app viewUserModel.	
	user ifNil: [ ^ #() ].

	tasksAll := user toDoItems.
	tasksFilterDone := self sideSheet filterDone.

	tasksFilterDone = #doneOnly
		ifTrue: [ ^ tasksAll select: [ :eachTask | eachTask done ] ].

	tasksFilterDone = #notDoneOnly
		ifTrue: [ ^ tasksAll reject: [ :eachTask | eachTask done ] ].

	^ tasksAll
]

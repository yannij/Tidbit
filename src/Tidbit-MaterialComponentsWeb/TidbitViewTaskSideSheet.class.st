Class {
	#name : #TidbitViewTaskSideSheet,
	#superclass : #MCWLayoutComponent,
	#instVars : [
		'user',
		'filterDone',
		'itemsStyle',
		'tabImportance'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
TidbitViewTaskSideSheet >> filterDone [
	^ filterDone
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> filterDone: anObject [
	filterDone := anObject
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> filterDoneSet: anObject [

	self filterDone: anObject.
	self mcwApplicationGet viewTask report: nil
]

{ #category : #initialization }
TidbitViewTaskSideSheet >> initialize [

	super initialize.

	self filterDone: #both.
	self tabImportance: TidbitToDoItem importanceValueHigh.
	self itemsStyle: #table
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> itemsStyle [
	^ itemsStyle
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> itemsStyle: anObject [
	itemsStyle := anObject
]

{ #category : #rendering }
TidbitViewTaskSideSheet >> renderContentOn: html [

	self renderFilterRadioButtonsOn: html.
	self renderItemsStyleRadioButtonsOn: html
]

{ #category : #rendering }
TidbitViewTaskSideSheet >> renderFieldLabel: aString on: html [

	html heading
		level6;
		mdcTypography_subtitle1;
		style: 'margin: 16px 0 8px';
		style: 'padding: 0 12px';
		with: aString
]

{ #category : #rendering }
TidbitViewTaskSideSheet >> renderFilterRadioButtonsOn: html [
	| formId group |

	self renderFieldLabel: 'Filter Done/Not-done' on: html.

	formId := html nextId.
	html form id: formId; with: [
	group := html radioGroup.
	{#both->'Both'. #doneOnly->'Done Only'. #notDoneOnly->'Not Done Only'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html div mdcFormField; style: 'width: 200px'; mdcAutoInit: 'MDCFormField'; with: [
				html div mdcRadio; mdcAutoInit: 'MDCRadio'; with: [
					html radioButton mdcRadio__nativeControl; id: optionId; group: group;
						selected: self filterDone = each key;
						callback: [ self filterDoneSet: each key ];
						onChange: (html jQuery ajax script: [ :s | s << (s jQuery id: formId) call: 'submit' ]);
						yourself.
					html div mdcRadio__background; with: [
						html div mdcRadio__outerCircle.
						html div mdcRadio__innerCircle ].
					html div mdcRadio__ripple ].
				html label for: optionId; with: each value ] ]
		separatedBy: [ html break ] ]
]

{ #category : #rendering }
TidbitViewTaskSideSheet >> renderItemsStyleRadioButtonsOn: html [
	| formId group |

	self renderFieldLabel: 'Items style' on: html.

	formId := html nextId.
	group := html radioGroup.
	html form id: formId; with: [
	{#table->'Table'. #listSingleLine->'List single-line'. #listTwoLine->'List two-line'. #chips->'Chips'. #cards->'Cards'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html div mdcFormField; style: 'width: 200px'; mdcAutoInit: 'MDCFormField'; with: [
				html div mdcRadio; mdcAutoInit: 'MDCRadio'; with: [
					html radioButton mdcRadio__nativeControl; id: optionId; group: group;
						selected: self itemsStyle = each key;
						callback: [ self itemsStyle: each key ];
						onChange: (html jQuery ajax script: [ :s | s << (s jQuery id: formId) call: 'submit' ]);
						yourself.
					html div mdcRadio__background; with: [
						html div mdcRadio__outerCircle.
						html div mdcRadio__innerCircle ].
					html div mdcRadio__ripple ].
				html label for: optionId; with: each value ] ]
		separatedBy: [ html break ] ]
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> tabImportance [
	^ tabImportance
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> tabImportance: anObject [
	tabImportance := anObject
]

{ #category : #accessing }
TidbitViewTaskSideSheet >> tabImportanceSelected [

	^ self tabImportance
		ifNil: [ TidbitToDoItem importanceValueHigh ]
		ifNotNil: [ :value | value ]
]

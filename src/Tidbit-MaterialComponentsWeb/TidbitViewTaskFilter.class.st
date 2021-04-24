Class {
	#name : #TidbitViewTaskFilter,
	#superclass : #MCWWebComponent,
	#instVars : [
		'user',
		'filterDone',
		'itemsStyle'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
TidbitViewTaskFilter >> filterDone [
	^ filterDone
]

{ #category : #accessing }
TidbitViewTaskFilter >> filterDone: anObject [
	filterDone := anObject
]

{ #category : #initialization }
TidbitViewTaskFilter >> initialize [

	super initialize.

	self filterDone: #both.
	self itemsStyle: #table
]

{ #category : #accessing }
TidbitViewTaskFilter >> itemsStyle [
	^ itemsStyle
]

{ #category : #accessing }
TidbitViewTaskFilter >> itemsStyle: anObject [
	itemsStyle := anObject
]

{ #category : #rendering }
TidbitViewTaskFilter >> renderContentOn: html [

	self renderFilterFormOn: html.
	self renderItemsStyleFormOn: html
]

{ #category : #rendering }
TidbitViewTaskFilter >> renderFilterFormOn: html [

	html form: [
		html submitButton mdcButton; mdcButton_raised; value: 'Filter'.
		html break.
		self renderFilterRadioButtonsOn: html ]
]

{ #category : #rendering }
TidbitViewTaskFilter >> renderFilterRadioButtonsOn: html [
	| group |

	group := html radioGroup.
	{#both->'Both'. #doneOnly->'Done Only'. #notDoneOnly->'Not Done Only'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html div mdcFormField; style: 'width: 200px'; mdcAutoInit: 'MDCFormField'; with: [
				html div mdcRadio; mdcAutoInit: 'MDCRadio'; with: [
					html radioButton mdcRadio__nativeControl; id: optionId; group: group;
						selected: self filterDone = each key;
						callback: [ self filterDone: each key ].
					html div mdcRadio__background; with: [
						html div mdcRadio__outerCircle.
						html div mdcRadio__innerCircle ].
					html div mdcRadio__ripple ].
				html label for: optionId; with: each value ] ]
		separatedBy: [ html break ]
]

{ #category : #rendering }
TidbitViewTaskFilter >> renderItemsStyleFormOn: html [

	html form: [
		html submitButton mdcButton; mdcButton_raised; value: 'Items style'.
		html break.
		self renderItemsStyleRadioButtonsOn: html ]
]

{ #category : #rendering }
TidbitViewTaskFilter >> renderItemsStyleRadioButtonsOn: html [
	| group |

	group := html radioGroup.
	{#table->'Table'. #listSingleLine->'List single-line'. #listTwoLine->'List two-line'. #chips->'Chips'. #cards->'Cards'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html div mdcFormField; style: 'width: 200px'; mdcAutoInit: 'MDCFormField'; with: [
				html div mdcRadio; mdcAutoInit: 'MDCRadio'; with: [
					html radioButton mdcRadio__nativeControl; id: optionId; group: group;
						selected: self itemsStyle = each key;
						callback: [ self itemsStyle: each key ].
					html div mdcRadio__background; with: [
						html div mdcRadio__outerCircle.
						html div mdcRadio__innerCircle ].
					html div mdcRadio__ripple ].
				html label for: optionId; with: each value ] ]
		separatedBy: [ html break ]
]

{ #category : #accessing }
TidbitViewTaskFilter >> user [
	^ user
]

{ #category : #accessing }
TidbitViewTaskFilter >> user: anObject [
	user := anObject
]

Class {
	#name : #TBViewTask,
	#superclass : #MCWWebComponent,
	#instVars : [
		'user'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #rendering }
TBViewTask >> renderContentOn: html [
	| tasks dataHeadings dataRows |

	tasks := self sessionUserGet ifNotNil: [:value | value toDoItems ] ifNil: [ #() ].

	html heading level6; mdcTypography_headline6; with: self sessionUserGet mdPrimaryString.

	dataHeadings := { 'Done'->false. 'Complete By Date'->false. 'Description'->false. 'Importance'->false. }.
	dataRows :=  OrderedCollection new.
	tasks do: [ :eachTask | | dataRow |
		dataRow := OrderedCollection new.
		dataRow add: eachTask done printString.
		dataRow add: eachTask completeByDate printString.
		dataRow add: eachTask description printString.
		dataRow add: eachTask importance printString.
		dataRows add: dataRow ].

	html div mdcDataTable with: [
		html div mdcDataTable__tableContainer; with: [ 
			html table mdcDataTable__table;  with: [
				html tableHead with: [
					html tableRow "mdcDataTable__headerRow" with: [
						dataHeadings do: [ :each | | tag |
							tag := html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each key.
							each value ifTrue: [ tag  mdcDataTable__headerCell_numeric ] ] ]
					].
				html tableBody mdcDataTable__content; with: [
					dataRows do: [ :eachRow |
						html tableRow mdcDataTable__row; with: [
							eachRow doWithIndex: [ :each :index | | tag |
								tag := html tableData mdcDataTable__cell; scope: 'row'; with: each.
								(dataHeadings at: index) value ifTrue: [ tag  mdcDataTable__headerCell_numeric ] ] ] ] ] ] ] ]
]

{ #category : #accessing }
TBViewTask >> sessionUserGet [

	^self session properties at: #user ifAbsent: [ nil ]
]

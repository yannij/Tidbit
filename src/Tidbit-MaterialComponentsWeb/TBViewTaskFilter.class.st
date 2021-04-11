Class {
	#name : #TBViewTaskFilter,
	#superclass : #MCWWebComponent,
	#instVars : [
		'user',
		'filterDone'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
TBViewTaskFilter >> filterDone [
	^ filterDone
]

{ #category : #accessing }
TBViewTaskFilter >> filterDone: anObject [
	filterDone := anObject
]

{ #category : #initialization }
TBViewTaskFilter >> initialize [

	super initialize.

	self filterDone: 'both'
]

{ #category : #rendering }
TBViewTaskFilter >> renderContentOn: html [

	html form: [
		self renderFilterFormOn: html ]
]

{ #category : #rendering }
TBViewTaskFilter >> renderFilterCheckboxOn: html [
	| checkboxId |

	checkboxId := html nextId.
	"html heading level2; mdcTypography_headline6; with: 'Filter Tasks By:'."
	html submitButton mdcButton; mdcButton_raised; value: 'Filter'.
	html break.
	html div mdcFormField; with: [
		html div mdcCheckbox; with: [
		html checkbox
			id: checkboxId;
			mdcCheckbox__nativeControl;
			on: #filterDone of: self;
			with: [
				html div mdcCheckbox__background with: [
					html svg mdcCheckbox__checkmark; attributeAt: 'viewBox' put: '0 0 24 24'; with: [
					html path
						mdcCheckbox__checkmarkPath;
						attributeAt: 'fill' put: 'none';
						attributeAt: 'stroke' put: 'white';
						attributeAt: 'd' put: 'M1.73,12.91 8.1,19.28 22.79,4.59';
						yourself.
					html div mdcCheckbox__mixedmark ] ] ] ].
		html label for: checkboxId; with: 'Done' ]
]

{ #category : #rendering }
TBViewTaskFilter >> renderFilterDoneOn: html [
	| group |

	group := html radioGroup.
	{'both'->'Both'. 'doneOnly'->'Done Only'. 'notDoneOnly'->'Not Done Only'}
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
TBViewTaskFilter >> renderFilterFormOn: html [

	html form: [
		html submitButton mdcButton; mdcButton_raised; value: 'Filter'.
		html break.
		self renderFilterDoneOn: html ]
]

{ #category : #accessing }
TBViewTaskFilter >> user [
	^ user
]

{ #category : #accessing }
TBViewTaskFilter >> user: anObject [
	user := anObject
]

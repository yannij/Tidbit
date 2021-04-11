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

	self filterDone: false
]

{ #category : #rendering }
TBViewTaskFilter >> renderContentOn: html [
	| checkboxId |

html form with: [
	checkboxId := html nextId.
	"html heading level2; mdcTypography_headline6; with: 'Filter Tasks By:'."
	html submitButton mdcButton; mdcButton_raised; value: 'Filter'.
	html break.
	html div mdcFormField; mcwFormField; with: [
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
					html div mdcCheckbox__mixedmark]]]].
		html label for: checkboxId; with: 'Done']
]
]

{ #category : #accessing }
TBViewTaskFilter >> user [
	^ user
]

{ #category : #accessing }
TBViewTaskFilter >> user: anObject [
	user := anObject
]

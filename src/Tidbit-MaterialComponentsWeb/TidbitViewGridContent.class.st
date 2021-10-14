Class {
	#name : #TidbitViewGridContent,
	#superclass : #MDSComponent,
	#instVars : [
		'contents'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
TidbitViewGridContent >> content1 [

	^ self contents at: 1 ifAbsent: [ nil ]
]

{ #category : #accessing }
TidbitViewGridContent >> content1: aComponent [

	self contents at: 1 put: aComponent
]

{ #category : #accessing }
TidbitViewGridContent >> content2 [

	^ self contents at: 2 ifAbsent: [ nil ]
]

{ #category : #accessing }
TidbitViewGridContent >> content2: aComponent [

	self contents at: 2 put: aComponent
]

{ #category : #accessing }
TidbitViewGridContent >> contents [
	^ contents
]

{ #category : #accessing }
TidbitViewGridContent >> contents: anObject [
	contents := anObject
]

{ #category : #initialization }
TidbitViewGridContent >> initialize [

	super initialize.

	self contents: (OrderedCollection with: nil with: nil)
]

{ #category : #rendering }
TidbitViewGridContent >> renderContentOn: html [
	| layout |

	layout := self mcwApplicationGet layout.

	html div mdcLayoutGrid;
		"style: 'border: 1px solid red';"
		with: [
		html div mdcLayoutGrid__inner; with: [
			self contents do: [ :each |
				html div mdcLayoutGrid__cell_span: layout cellSpan; with: [
					html render: each ] ] ] ]

]

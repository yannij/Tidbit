Class {
	#name : #MDLDateInputComponent,
	#superclass : #MDLTextInputComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #accessing }
MDLDateInputComponent >> dateISO [

	^ self value
		ifNil: [ Date today yyyymmdd ]
		ifNotNil: [:t | t yyyymmdd ]

]

{ #category : #accessing }
MDLDateInputComponent >> dateISO: aString [

	aString isEmpty ifFalse: [
		self value: (Date fromString: aString) ]
]

{ #category : #accessing }
MDLDateInputComponent >> dateISOString [

	^ self value
		ifNil: [ Date today yyyymmdd ]
		ifNotNil: [:t | t ]

]

{ #category : #accessing }
MDLDateInputComponent >> dateISOString: aString [

	aString isEmpty ifFalse: [
		self value: aString ]
]

{ #category : #rendering }
MDLDateInputComponent >> inputAspect [

	^ #dateISOString
]

{ #category : #rendering }
MDLDateInputComponent >> inputType [

	^ 'date'
]

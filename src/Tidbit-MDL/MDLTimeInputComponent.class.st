Class {
	#name : #MDLTimeInputComponent,
	#superclass : #MDLTextInputComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLTimeInputComponent >> inputAspect [

	^ #timeISO
]

{ #category : #rendering }
MDLTimeInputComponent >> inputType [

	^ 'time'
]

{ #category : #accessing }
MDLTimeInputComponent >> timeISO [

	^ self value
		ifNil: [ Time now print24 ]
		ifNotNil: [:t | t print24 ]
]

{ #category : #accessing }
MDLTimeInputComponent >> timeISO: aString [

	aString isEmpty ifFalse: [
		self value: (Time fromString: aString) ]
]

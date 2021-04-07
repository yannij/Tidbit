Class {
	#name : #MDLTimeStampInputComponent,
	#superclass : #MDLTextInputComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #accessing }
MDLTimeStampInputComponent >> datetimeISO [

	^ self value
		ifNil: [ DateAndTime now printString ]
		ifNotNil: [:t | t printString ]
]

{ #category : #accessing }
MDLTimeStampInputComponent >> datetimeISO: aString [

	aString isEmpty ifFalse: [
		self value: (DateAndTime fromString: aString) ]
]

{ #category : #rendering }
MDLTimeStampInputComponent >> inputAspect [

	^ #datetimeISO
]

{ #category : #rendering }
MDLTimeStampInputComponent >> inputType [

	^ 'datetime'
]

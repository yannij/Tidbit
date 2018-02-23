accessing
datetimeISO

	^ self value
		ifNil: [ DateAndTime now printString ]
		ifNotNil: [:t | t printString ]
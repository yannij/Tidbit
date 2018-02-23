accessing
timeISO

	^ self value
		ifNil: [ Time now print24 ]
		ifNotNil: [:t | t print24 ]
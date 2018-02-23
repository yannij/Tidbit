accessing
dateISO

	^ self value
		ifNil: [ Date today yyyymmdd ]
		ifNotNil: [:t | t yyyymmdd ]

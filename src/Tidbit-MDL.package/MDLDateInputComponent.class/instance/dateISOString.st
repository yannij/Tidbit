accessing
dateISOString

	^ self value
		ifNil: [ Date today yyyymmdd ]
		ifNotNil: [:t | t ]

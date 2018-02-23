accessing
datetimeISO: aString

	aString isEmpty ifFalse: [
		self value: (DateAndTime fromString: aString) ]
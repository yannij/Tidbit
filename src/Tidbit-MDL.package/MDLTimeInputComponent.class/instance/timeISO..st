accessing
timeISO: aString

	aString isEmpty ifFalse: [
		self value: (Time fromString: aString) ]
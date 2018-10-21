initalize
getSessionUser

	^self session properties at: #user ifAbsent: [ nil ]

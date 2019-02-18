accessing - model
getSessionUser

	^self session properties at: #user ifAbsent: [ nil ]

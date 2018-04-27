printing
mdDisplaySecondaryString

	^(self done ifTrue: ['DONE'] ifFalse: ['NOT-DONE']),
		', ', 'Priority ', self priority printString,
		', ', 'Complete by  ', self completeByDate printString
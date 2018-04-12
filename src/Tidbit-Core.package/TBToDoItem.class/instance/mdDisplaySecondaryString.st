printing
mdDisplaySecondaryString

	^(self done ifTrue: ['DONE'] ifFalse: ['To Do']),
		', ', 'Priority: ', self priority printString
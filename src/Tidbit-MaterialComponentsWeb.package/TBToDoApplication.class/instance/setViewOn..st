initialization
setViewOn: aModel
	| newView |

	aModel isNil
		ifTrue: [ ^self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self layout contentArea component content1: newView.

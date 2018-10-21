actions
setViewOn: aModel
	| newView |

	aModel isNil
		ifTrue: [ ^self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	"self view: newView."
	self canvas content1: newView.

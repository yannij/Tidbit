actions
setCanvasContent2: aModel
	| newView |

	aModel isNil
		ifTrue: [ ^self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	"self view: newView."
	self canvas content2: newView.

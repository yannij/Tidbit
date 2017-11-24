actions
setViewOn: aModel
	| newModel newView |

	aModel isNil
		ifTrue: [ ^self ].

	newModel := TBToDoItem new
					done: false;
					description: aModel asString;
					yourself.
	newView := newModel asComponent
					addValidatedForm;
					addMessage: 'hello';
					yourself.

	self view: newView.

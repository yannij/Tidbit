rendering
renderAddButtonOn: html

	html mdlButton
		"raised; colored;"
		value: 'Add';
		"callback: [ self parent add ];"
		onClick: ((html jQuery ajax)
			callback: [ self parent add ];
			onComplete: html javascript refresh);
		yourself.

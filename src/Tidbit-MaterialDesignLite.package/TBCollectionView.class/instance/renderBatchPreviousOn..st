rendering
renderBatchPreviousOn: html

	self isOnFirstPage
		ifFalse: [ html anchor callback: [ self previousPage ]; with: [html mdlIcon: #keyboard_arrow_left] ]
		ifTrue: [ html mdlIcon: #keyboard_arrow_left ].
	html space

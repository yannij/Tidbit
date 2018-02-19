rendering
renderBatchNextOn: html

	self isOnLastPage
		ifFalse: [ html anchor callback: [ self nextPage ]; with: [html mdlIcon: #keyboard_arrow_right] ]
		ifTrue: [ html mdlIcon: #keyboard_arrow_right ].

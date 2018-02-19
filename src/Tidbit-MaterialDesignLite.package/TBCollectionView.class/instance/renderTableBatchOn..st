rendering
renderTableBatchOn: html
	self hasMoreThanOnePage ifTrue: [
					self showBatchFirstLast
						ifTrue: [ self renderBatchFirstOn: html ].
					self showBatchPreviousNext
						ifTrue: [ self renderBatchPreviousOn: html ].
					self showBatchPages
						ifTrue: [ self renderBatchItemsOn: html ].
					self showBatchPreviousNext
						ifTrue: [ self renderBatchNextOn: html ].
					self showBatchFirstLast
						ifTrue: [ self renderBatchLastOn: html ] ]
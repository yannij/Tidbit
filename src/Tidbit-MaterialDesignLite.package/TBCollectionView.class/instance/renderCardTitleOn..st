rendering
renderCardTitleOn: html
	| cardTitle |

	cardTitle := html mdlCardTitle.
	self flushTop
		ifTrue: [ cardTitle style: 'padding-bottom: 0px;' ].

	cardTitle
		"style: 'padding-left: 24px;';"
		with: [
			"self title ifNotNil: [ html mdlCardTitleText: self title level: 2 ]."
			((self showBatch and: [ self hasMoreThanOnePage ]) or: [ self showFooter ])
				ifTrue: [
					html mdlCardActions with: [
						self showFooter
							ifTrue: [ self renderTableFootOn: html ].
						self showBatch
							ifTrue: [ self renderTableBatchOn: html ] ] ].
			html mdlLayoutSpacer.
			self showAddButton ifTrue: [self renderSelectListOn: html] ].

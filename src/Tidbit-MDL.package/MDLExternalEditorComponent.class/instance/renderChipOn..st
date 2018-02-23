rendering
renderChipOn: html

	self value ifNil: [ ^self ].

	html mdlChip
		"deleteCallback: [
					self removeBlock isNil
						ifTrue: [
							[ self parent remove: self ] ]
						ifFalse: [
							[self session presenter removeFromRecentlyViewed: self.
							[self removeBlock value: self] value]]
			];"
		with: [ 
			html anchor
				"callback: [ self parent primaryActionOn: self ];"
				with: [
					"html mdlIcon chipIcon with: self chipIconName."
					html mdlChipText with: self value conciseId ] ] 
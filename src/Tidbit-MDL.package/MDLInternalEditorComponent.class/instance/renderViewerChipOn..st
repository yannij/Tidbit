rendering
renderViewerChipOn: html

	self value ifNil: [ ^self ].

	html mdlChip
		with: [ 
			html anchor
				"callback: [ self parent primaryActionOn: self ];"
				with: [
					"html mdlIcon chipIcon with: self chipIconName."
					html mdlChipText with: self value conciseId ] ] 
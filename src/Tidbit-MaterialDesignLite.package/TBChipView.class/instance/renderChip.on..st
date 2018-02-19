rendering
renderChip: anItem on: html

	html mdlChip
		deleteCallback: [
					self removeBlock isNil
						ifTrue: [
							[ self parent remove: anItem.
							"self session presenter activeScreen objectInstance removeInstance: anItem"] ]
						ifFalse: [
							[self session presenter removeFromRecentlyViewed: anItem.
							[self removeBlock value: anItem] value]]
			];
		with: [ 
			html anchor
				callback: [ self parent primaryActionOn: anItem ];
				with: [
					"html mdlIcon chipIcon with: anItem chipIconName."
					html mdlChipText "style: 'width: 240px';" with: anItem mdlDisplayId ] ] 
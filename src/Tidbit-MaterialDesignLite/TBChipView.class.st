Class {
	#name : #TBChipView,
	#superclass : #TBCollectionView,
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #rendering }
TBChipView >> renderChip: anItem on: html [

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
]

{ #category : #rendering }
TBChipView >> renderContentOn: html [

	self renderListOn: html.
	self renderCardTitleOn: html.

]

{ #category : #rendering }
TBChipView >> renderListOn: html [

	self visible
		do: [ :each | self renderChip: each on: html ]
		separatedBy: [ html space ].

]

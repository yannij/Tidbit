Class {
	#name : #TBGridView,
	#superclass : #TBCollectionView,
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #rendering }
TBGridView >> renderCell: anItem on: html [

	html mdlCell
		size: 3;
		shadow: 2;
		style: 'min-height: 100px;';
		with: [ 
			html anchor
				callback: [ self parent primaryActionOn: anItem ];
				with: [
			html mdlCardTitle
				"style: 'align-items: flex-start; color: #fff';
				expand;"
				with: [ html mdlCardTitleText
						"style: 'margin-top: 0; align-self: flex-start';"
						"level: 4;"
						with: [ html text: anItem mdlDisplayString ] ].
					"html mdlIcon chipIcon with: anItem chipIconName."
					"html mdlChipText style: 'width: 240px'; with: anItem conciseString"
					] ] 
]

{ #category : #rendering }
TBGridView >> renderContentOn: html [

	html mdlGrid
		"style: 'margin: 0';"
		"shadow: 2;"
		"style: 'overflow-x: auto; width: 100%;';"
		with: [
			"self renderCardTitleOn: html."
			self renderListOn: html ]

]

{ #category : #rendering }
TBGridView >> renderListOn: html [

	self visible do: [ :each | 
		self renderCell: each on: html ].

]

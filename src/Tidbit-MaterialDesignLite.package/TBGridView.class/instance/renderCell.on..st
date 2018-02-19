rendering
renderCell: anItem on: html

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
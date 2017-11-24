rendering
renderContentAndRightNavOn: html

	html mdlLayoutContent
		style: 'width: 100%';
		with: [
		html mdlGrid
			class: 'mdl-layout--small-screen-only';
			class: 'mdl-grid--no-spacing';
			with: [ 
				html mdlCell size: 12; with: [ html render: (TBToolNav new) ].
			].
		html mdlGrid
			class: 'mdl-grid--no-spacing';
			with: [ 
				html mdlCell
					size: 10; stretch;
					with: [ 
						html mdlCard
							style: 'overflow-x: auto; width: 100%;';
							with: [ html render: self session presenter view ] ].
				self renderRightNavCellOn: html.
		] ].
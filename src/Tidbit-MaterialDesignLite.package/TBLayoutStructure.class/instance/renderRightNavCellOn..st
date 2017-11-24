rendering
renderRightNavCellOn: html

		html mdlCell
			hidePhone;
			size: 2; stretch;
			with: [ 
				html mdlCard
					style: 'overflow-x: auto; width: 100%;';
					with: [ self renderRightNavDivOn: html ] ].

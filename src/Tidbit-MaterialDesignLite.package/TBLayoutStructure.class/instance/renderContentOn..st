rendering
renderContentOn: html

	html div
		style: 'min-height: 400px';
		with: [self renderContentAndRightNavOn: html].

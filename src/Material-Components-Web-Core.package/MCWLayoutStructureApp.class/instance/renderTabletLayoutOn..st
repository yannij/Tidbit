rendering
renderTabletLayoutOn: html

	self renderSideNavOn: html.


	html div
		class: 'demo-content';
		with: [
			self renderAppBarOn: html.
			self renderContentCanvasOn: html.
			self renderBottomBarOn: html.
			self renderScriptOn: html.
		].

	self renderRightNavOn: html.

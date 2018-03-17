rendering
renderLayoutStructureMobileOn: html

	html render: self sideNav.
	html render: self rightNav.

	html div
      "Stack toolbar and main on top of each other"
		style: 'display: inline-flex; flex-direction: column; flex-grow: 1; height: 100%; box-sizing: border-box;';
		with: [
			html render: self header.
			html text: 'mobile'.
			self renderContentCanvasOn: html.
			html render: self footer.
			html render: self mainFab.
			self renderScriptOn: html.
		].

rendering
renderContentCanvasOn: html

	(html tag: 'main')
		style: 'padding-left: 16px; padding-right: 16px';
		"style: 'width: 100%';"
		style: 'overflow-x: auto';
		class: #'mdc-toolbar-fixed-adjust' if: self isLayoutStructureDesktop not;
		with: [
			html paragraph
				class: 'mdc-typography--body1';
				with: 'Content canvas - ', self layoutStructure asString.
			self renderLayoutSwitchOn: html.

			self renderExtraWideAnchorButtonOn: html.
			self renderExtraTallAnchorButtonOn: html.
			self renderExtraWideButtonOn: html.
			self renderExtraTallButtonOn: html.

			self renderExtraWideOn: html.
			self renderExtraTallOn: html.

			html render: self mainFab.
		]
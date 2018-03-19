rendering
renderContentCanvasOn: html

	(html tag: 'main')
		style: 'padding-left: 16px; padding-right: 16px';
		style: 'width: 100%';
		class: #'mdc-toolbar-fixed-adjust' if: self isLayoutStructureDesktop not;
		with: [
			html paragraph
				class: 'mdc-typography--body1';
				with: 'Content canvas'.
			self renderLayoutSwitchOn: html.
			html break.
			html div
				class: 'mdc-elevation--z2';
				style: 'height: 50vh';
				with: [html text: self layoutStructure asString].
			html render: self mainFab.
		]
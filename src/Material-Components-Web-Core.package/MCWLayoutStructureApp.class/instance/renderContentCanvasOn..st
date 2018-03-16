rendering
renderContentCanvasOn: html

	(html tag: 'main')
		class: 'demo-main';
		with: [
			html paragraph
				class: 'mdc-typography--body1';
				with: 'Content canvas'.
			html div
				id: 'extra-tall-content';
				class: 'mdc-elevation--z2';
				with: [html space].
			html break]
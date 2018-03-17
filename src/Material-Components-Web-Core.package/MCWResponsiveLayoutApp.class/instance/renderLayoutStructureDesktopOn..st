rendering
renderLayoutStructureDesktopOn: html

	"html div class: 'mdc-layout-grid'; with: [
		html div class: 'mdc-layout-grid__inner'; with: [
			html div class: 'mdc-layout-grid__cell mdc-layout-grid__cell--span-12'; with: [
				html render: self header]]]."
"	html render: self header."

	html div
		style: 'display: inline-flex; flex-direction: row; flex-grow: 1; box-sizing: border-box;';
		with: [
			html render: self header].

	html div
		style: 'display: inline-flex; flex-direction: row; flex-grow: 1; height: 100%; box-sizing: border-box;';
		with: [
			html render: self sideNav.
			self renderContentCanvasOn: html.
			html render: self rightNav.
			html render: self mainFab.
			self renderScriptOn: html.
		].

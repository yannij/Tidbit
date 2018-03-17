rendering
renderLayoutSwitchOn: html

	html div
		class: 'mdc-elevation--z2';
		"style: 'height: 50vh';"
		with: [
			html render: (MCWButton new buttonLabel: 'Mobile'; callback: [self beLayoutStructureMobile]; yourself).
			html render: (MCWButton new buttonLabel: 'Tablet'; callback: [self beLayoutStructureTablet]; yourself).
			html render: (MCWButton new buttonLabel: 'Desktop'; callback: [self beLayoutStructureDesktop]; yourself).
		].

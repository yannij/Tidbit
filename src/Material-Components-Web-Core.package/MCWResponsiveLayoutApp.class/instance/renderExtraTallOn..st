rendering
renderExtraTallOn: html

	html div
		id: self extraTallId;
		class: 'mdc-elevation--z2';
		class: 'mdc-theme--secondary-bg mdc-theme--text-primary-on-secondary';
		style: 'margin-top: 16px';
		style: 'height: 200vh';
		style: (self extraTallShown ifTrue: [nil] ifFalse: ['display: none']);
		with: 'Extra Tall'.

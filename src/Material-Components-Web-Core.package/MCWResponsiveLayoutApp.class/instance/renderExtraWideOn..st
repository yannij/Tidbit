rendering
renderExtraWideOn: html

	html div
		id: self extraWideId;
		class: 'mdc-elevation--z2';
		class: 'mdc-theme--secondary-bg mdc-theme--text-primary-on-secondary';
		style: 'margin-top: 16px';
		style: 'width: 200vw';
		style: (self extraWideShown ifTrue: [nil] ifFalse: ['display: none']);
		with: 'Extra Wide'.

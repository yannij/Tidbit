rendering
renderContentOn: html

	html anchor
		id: self id;
		class: 'mdc-button';
		callback: self callback;
		with: [
			html text: self buttonLabel].

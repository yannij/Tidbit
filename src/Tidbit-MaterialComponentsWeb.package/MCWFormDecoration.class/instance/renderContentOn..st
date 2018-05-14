rendering
renderContentOn: html
	| formId |

	formId := html nextId.

	html form
		class: 'magritte';
		multipart: self requiresMultipartForm;
		defaultAction: [self execute: self default];
		with: [
			html div mdcCard; style: 'padding: 8px'; with: [
				self renderButtonsOn: html withFormId: formId.
				self renderNextOn: html]]
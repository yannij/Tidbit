rendering
renderViewerOn: html

	html unorderedList
		class: 'mdc-list';
		class: 'mdc-list--two-line';
		style: 'border: 1px solid rgba(0, 0, 0, 0.1);';
		with: [
			html heading level3
				mdcListGroup__subheader;
				with: self magritteDescription label.
			self value do: [:eachItem |
				html listItem
					mdcListItem;
					with: [
						html span
							mdcListItem__text;
							with: [
								html text: eachItem mdPrimaryString.
								html span
									mdcListItem__secondaryText;
									with: [html text: eachItem mdDisplaySecondaryString]].
						html html: '<span class="mdc-list-item__meta">
<i class="material-icons" aria-hidden="true">more_vert</i></span>']]]
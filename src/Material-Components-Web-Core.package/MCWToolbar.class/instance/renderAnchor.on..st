rendering
renderAnchor: anchorValues on: html

	html anchor
		class: 'material-icons'; class: 'mdc-toolbar__menu-icon';
		attributeAt: 'aria-label' put: anchorValues first;
		attributeAt: 'alt' put: anchorValues first;
		url: '#';
		with: anchorValues second.
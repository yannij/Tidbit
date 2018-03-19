rendering
renderAnchor: anchorValues on: html
	| anchor |

	anchor := html anchor.

	anchorValues first = 'Menu'
		ifTrue: [
			html button
				class: 'demo-menu'; class: 'material-icons'; class: 'mdc-toolbar__menu-icon';
				"onClick: (JSScript new add: 'drawer.open = !drawer.open;');"
				onClick: 'element = document.getElementById(''', 'sideNavDrawer', ''');
element.mdcDrawer.open = !element.mdcDrawer.open';
				with: anchorValues second.
			html space; space.
			^self].

	anchorValues first = 'Right Nav'
		ifTrue: [
			html button
				class: 'demo-menu'; class: 'material-icons'; class: 'mdc-toolbar__menu-icon';
				"onClick: (JSScript new add: 'drawerRight.open = !drawerRight.open;');"
				onClick: 'element = document.getElementById(''', 'rightNavDrawer', ''');
element.mdcDrawer.open = !element.mdcDrawer.open';
				with: anchorValues second.
			html space; space.
			^self].

	anchor
		class: 'material-icons'; class: 'mdc-toolbar__menu-icon';
		attributeAt: 'aria-label' put: anchorValues first;
		attributeAt: 'alt' put: anchorValues first;
		url: '#';
		with: anchorValues second.
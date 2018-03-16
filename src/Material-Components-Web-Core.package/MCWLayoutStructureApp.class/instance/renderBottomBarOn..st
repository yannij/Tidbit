rendering
renderBottomBarOn: html
	| toolbar |

	toolbar := MCWToolbar new
		title: 'Bottom bar';
		yourself.

	html render: toolbar.

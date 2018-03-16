rendering
renderRightNavOn: html
	| drawer |

	drawer := MCWDrawer new
		list: {'star' -> 'Right 1'. 'star' -> 'Right 2'};
		yourself.

	html render: drawer.

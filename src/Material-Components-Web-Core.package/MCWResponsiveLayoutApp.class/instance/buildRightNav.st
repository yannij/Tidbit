initialization
buildRightNav

	^MCWDrawer new
		id: 'drawerRight';
		list: {'star' -> 'Right 1'. 'star' -> 'Right 2'};
		beTemporaryDrawer;
		beDirectionToRightToLeft;
		yourself.

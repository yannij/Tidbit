initialization
buildRightNav

	^MCWDrawer new
		id: self rightNavDrawerId;
		list: {'star' -> 'Right 1'. 'star' -> 'Right 2'};
		beTemporaryDrawer;
		beDirectionToRightToLeft;
		yourself.

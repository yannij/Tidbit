initialization
buildSideNav

	^MCWDrawer new
		id: self sideNavDrawerId;
		list: {'star' -> 'Action 1'. 'star' -> 'Action 2'. 'star' -> 'Action 3'. 'star' -> 'Action 4'};
		yourself.

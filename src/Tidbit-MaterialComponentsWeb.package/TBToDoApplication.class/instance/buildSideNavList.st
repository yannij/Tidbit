initialization
buildSideNavList

	^MCWListBasic new
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: [self sideNav menuItemCallback]);
		addListItem: (MCWListItemIcon  itemText: 'Recent' iconName: 'history' callback: [self sideNav menuItemCallback]);
		addListItem: (MCWListItemIcon  itemText: 'Favs' iconName: 'favorite' callback: [self sideNav menuItemCallback]);
		yourself.

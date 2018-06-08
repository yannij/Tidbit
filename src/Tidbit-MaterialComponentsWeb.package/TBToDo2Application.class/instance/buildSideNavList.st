initialization
buildSideNavList

	^MCWListBasic new
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: []);
		addListItem: (MCWListItemIcon  itemText: 'Recent' iconName: 'history' callback: []);
		addListItem: (MCWListItemIcon  itemText: 'Favs' iconName: 'favorite' callback: []);
		yourself.

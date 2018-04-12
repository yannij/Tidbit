initalize
buildSideNavMenuList

	^MCWListBasic new
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: []);
		addListItem: (MCWListItemIcon  itemText: 'Recent' iconName: 'history' callback: []);
		addListItem: (MCWListItemIcon  itemText: 'Favs' iconName: 'favorite' callback: []);
		addListItem: (MCWListItemIcon  itemText: 'Custom' iconName: 'star' callback: [self colorThemeExample]);
		addListItem: (MCWListItemIcon  itemText: 'Custom (Clear)' iconName: 'star' callback: [self colorThemeExampleClear]);
		yourself.

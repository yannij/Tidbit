initailize-release
buildDrawer

	^ TBNavigationLinksSection new
		links: (OrderedCollection new
			add: (OrderedCollection new
				add: 'Recent' -> [ self session presenter switchToRecent ];
				add: 'Favs' -> [ self session presenter switchToFavs ];
				yourself);
			yourself);
		yourself
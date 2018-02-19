initailize-release
buildDrawer

	^ TBNavigationLinksSection new
		links: (OrderedCollection new
			add: (OrderedCollection new
				add: 'Home' -> [ self session presenter switchToHome ];
				add: 'Recent' -> [ self session presenter switchToRecent ];
				add: 'Favs' -> [ self session presenter switchToFavs ];
				yourself);
			yourself);
		yourself
rendering
rightNavLinks
	| quickLinks |

	quickLinks := (OrderedCollection new
				add: 'Recent' -> [ self session presenter switchToRecent ];
				add: 'Favs' -> [ self session presenter switchToFavs ];
				yourself).

	^quickLinks
rendering
rightNavLinks
	| quickLinks |

	quickLinks := (OrderedCollection new
				add: 'RightNav1' -> [ self session presenter switchToHome ];
				add: 'RightNav2' -> [ self session presenter switchToHome ];
				add: 'RightNav3' -> [ self session presenter switchToHome ];
				add: 'RightNav4' -> [ self session presenter switchToHome ];
				yourself).

	^quickLinks
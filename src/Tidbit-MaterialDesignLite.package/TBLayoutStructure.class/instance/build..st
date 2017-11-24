initailize-release
build: aDictionary
	| screenLayout |

	screenLayout := MDLLayoutWidget new title: 'ToDo'; yourself.

	(aDictionary at: 'sideNav' ifAbsent: [ true ])
		ifTrue: [
			screenLayout
				drawerSection: self buildDrawer;
				fixedDrawer].

	screenLayout
		headerSection: TBHeaderSection new;
		fixedHeader.

	self addDecoration: (MDLScreenLayout newWithLayout: screenLayout).

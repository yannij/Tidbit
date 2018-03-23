initialization
initialize

	super initialize.

	self layoutStructure: #tablet.
	self rebuildHeader.
	self bottomBar: self buildBottomBar.
	self footer: self buildFooter.

	self sideNav: self buildSideNav.
	self sideNav toolbar
		mcwStyle: 'background-color: #CD4067';
		title: 'Toolbar';
		yourself.

	self rightNav: self buildRightNav.
	self rightNav toolbar
		mcwStyle: 'background-color: #CD4067';
		title: 'Toolbar';
		yourself.

	self mainFab: self buildMainFab.
	self secondaryToolbar: (MCWToolbar new title: 'Secondary toolbar'; mcwStyle: 'background-color: #D5D5D5'; yourself).

	self extraWideShown: false.
	self extraTallShown: false.
	self beLayoutStructureTablet.

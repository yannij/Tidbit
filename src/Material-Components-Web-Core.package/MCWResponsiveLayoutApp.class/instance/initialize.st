initialization
initialize

	super initialize.

	self appBar: self buildAppBar.
	self header: self buildHeader.
	self bottomBar: self buildBottomBar.
	self footer: self buildFooter.

	self sideNav: self buildSideNav.
	self rightNav: self buildRightNav.
	self mainFab: self buildMainFab.

	self extraWideShown: false.
	self extraTallShown: false.
	self beLayoutStructureTablet.

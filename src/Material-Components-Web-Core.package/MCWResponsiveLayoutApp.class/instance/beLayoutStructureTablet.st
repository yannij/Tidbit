actions
beLayoutStructureTablet

	self layoutStructure: #tablet.
	self sideNav bePersistentDrawer.
	self rightNav beTemporaryDrawer.
	self rightNav beDirectionToRightToLeft

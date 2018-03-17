accessing
beLayoutStructureMobile

	self layoutStructure: #mobile.
	self sideNav bePersistentDrawer.
	self rightNav beTemporaryDrawer.
	self rightNav beDirectionToRightToLeft

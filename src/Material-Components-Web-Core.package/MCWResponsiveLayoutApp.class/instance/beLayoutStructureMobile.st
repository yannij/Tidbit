actions
beLayoutStructureMobile

	self layoutStructure: #mobile.
	self sideNav beTemporaryDrawer.
	self rightNav beTemporaryDrawer.
	self rightNav beDirectionToRightToLeft

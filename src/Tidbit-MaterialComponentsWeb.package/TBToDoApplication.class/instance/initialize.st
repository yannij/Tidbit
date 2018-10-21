initialization
initialize

	super initialize.

	self settings setFont: MCWGoogleFont allAvailable atRandom.
	self canvas: MCWCanvasGridComponent new.

	self setSessionUser: self retrieveTestModel.
	self setViewOn: self getSessionUser.

	self applicationPostInitialize: self

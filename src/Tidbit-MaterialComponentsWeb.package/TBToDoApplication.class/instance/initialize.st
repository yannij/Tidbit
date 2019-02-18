initialization
initialize

	super initialize.

	self settings setFont: MCWGoogleFont allAvailable atRandom.
	self layout contentArea component: TBContentGrid new.

	self setSessionUser: self retrieveTestModel.
	self setViewOn: self getSessionUser.

	self applicationPostInitialize: self

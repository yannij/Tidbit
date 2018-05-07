initalize
initialize

	super initialize.

	"self primaryColor: user primaryColor secondaryColor: user secondaryColor."
	"self primaryColor: MDLColor randomColorAndTint secondaryColor: MDLColor randomColorAndTint."

	self sideNav toolbar: nil.
	self secondaryToolbar: nil.
	self canvas: MCWCanvasGridComponent new.

	self setSessionUser: self retrieveTestModel.
	self setViewOn: self getSessionUser.

	self applicationPostInitialize: self

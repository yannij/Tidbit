initalize
initialize

	super initialize.

	"self primaryColor: user primaryColor secondaryColor: user secondaryColor."
	self primaryColor: MDLColor randomColorAndTint secondaryColor: MDLColor randomColorAndTint.

	self setViewOn: nil.

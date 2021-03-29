initalize
repositoryClear
	"
	self repositoryClear
	"

	Repository ifNotNil: [
		"Repository database close."
		Repository := nil ]

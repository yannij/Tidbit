patch
requiresMultipartForm
	"Answer true if the receiving component or one of its children requires a multipart form."

	^ self children anySatisfy: [ :each | each notNil and: [ each requiresMultipartForm ] ]
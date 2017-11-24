class initialization
initialize
	"Register path with Seaside.
	WAAdmin unregister: 'tidbit-todo'.
	"

	^ self registerToDevelopment: 'tidbit-todo'

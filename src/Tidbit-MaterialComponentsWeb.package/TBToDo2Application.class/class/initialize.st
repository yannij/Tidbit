class initialization
initialize
	"Register path with Seaside.
	WAAdmin unregister: 'tidbit-todo2'.
	"

	^ self registerToDevelopment: 'tidbit-todo2'

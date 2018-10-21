class initialization
initialize
	"Register path with Seaside.
	WAAdmin unregister: 'tidbit/todo-mdl'.
	"

	^ self registerToDevelopment: 'tidbit/todo-mdl'

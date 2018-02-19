open/close
open
	database ifNotNil: [ self close ].
	database := LmdbDatabase open: databaseReference path basename.

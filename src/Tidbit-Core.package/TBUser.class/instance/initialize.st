initalize
initialize

	super initialize.

	self userId: String new.
	self passwordHash: 'secret'.
	self dateCreated: DateAndTime now.
	self firstName: String new.
	self lastName: String new.
	self toDoItems: OrderedCollection new.

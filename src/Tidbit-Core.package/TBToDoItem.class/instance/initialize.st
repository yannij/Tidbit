initalize
initialize

	super initialize.

	self done: false.
	self description: String new.
	self completeByDate: Date today.
	self priority: 0.

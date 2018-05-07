initalize
initialize

	super initialize.

	self done: false.
	self description: String new.
	self completeByDate: DateAndTime now.
	self priority: 0.
	self bestTimeOfDayToStart: Time now.
	self actualDateStarted: Date today.
	self estimatedDuration: 1 hour.
	self importance: 'Medium'.
	self calendars: OrderedCollection new.

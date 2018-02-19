closing
close

	self isOpen ifFalse: [ ^self ].

	self environment close.
	self environment: nil.

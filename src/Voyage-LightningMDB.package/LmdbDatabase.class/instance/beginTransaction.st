transactions
beginTransaction

	[
		self transaction: self environment beginTransaction.
		self database: (self transaction openDatabase: nil "Use default database").
		^true]
			on: Error
			do: [^false]

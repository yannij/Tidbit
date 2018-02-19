transactions
rollbackTransaction

	[
		self transaction abort.
		^true]
			on: Error
			do: [^false]

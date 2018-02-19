transactions
commitTransaction

	[
		self transaction commit.
		^true]
			on: Error
			do: [:ex | ex inspect. ^false]

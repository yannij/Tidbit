accessing - model
retrieveTestModel

	^(TBExampleDatabase repository selectAll: TBUser)
		ifEmpty: [nil]
		ifNotEmpty: [:value | value anyOne]
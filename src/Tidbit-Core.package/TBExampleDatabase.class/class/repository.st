initalize
repository

	Repository ifNil: [Repository := VOLightningMDBRepository on: self repositoryName].
	^Repository

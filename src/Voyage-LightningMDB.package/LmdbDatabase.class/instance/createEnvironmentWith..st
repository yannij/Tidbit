opening
createEnvironmentWith: aNameString

	^MDBEnvironment create
		setMaxdbs: 12;
		setMapsize: 100 * 1024 * 4096; 					"400MB"
		open: (self path: aNameString) flags: 0;
		yourself
opening
open: filePath

	self isOpen ifTrue: [ ^self ].

	self environment: (self createEnvironmentWith: filePath).

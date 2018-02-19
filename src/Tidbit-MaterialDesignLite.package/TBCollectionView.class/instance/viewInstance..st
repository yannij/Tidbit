actions
viewInstance: aModelInstance

	self session inspect.

	self
		show: (self
			buildViewerFor: aModelInstance
			titled: aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
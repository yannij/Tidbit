actions
viewInstance: aModelInstance

	self
		show: (self
			buildViewerFor: aModelInstance
			titled: aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
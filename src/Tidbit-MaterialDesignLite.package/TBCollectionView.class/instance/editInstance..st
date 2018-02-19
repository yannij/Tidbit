actions
editInstance: aModelInstance

	self
		show: (self
			buildEditorFor: aModelInstance
			titled: 'Edit ' , aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
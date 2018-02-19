actions
editInstance: aModelInstance

	self session presenter addToRecent: aModelInstance.

	self
		show: (self
			buildEditorFor: aModelInstance
			titled: 'Edit ' , aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
Class {
	#name : #TBTableView,
	#superclass : #MAReport,
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #actions }
TBTableView >> buildEditorFor: anObject titled: aString [

	^ anObject asComponent
		addValidatedForm;
		addMessage: aString;
		yourself
]

{ #category : #actions }
TBTableView >> buildViewerFor: anObject titled: aString [

	^ anObject asComponent
		addMessage: aString;
		yourself
]

{ #category : #actions }
TBTableView >> edit: aModelInstance [

	self session presenter addToRecent: aModelInstance.

]

{ #category : #actions }
TBTableView >> editInstance: aModelInstance [

	self session presenter addToRecent: aModelInstance.

	self
		show: (self
			buildEditorFor: aModelInstance
			titled: 'Edit ' , aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
]

{ #category : #actions }
TBTableView >> refresh [
	super refresh.

]

{ #category : #actions }
TBTableView >> removeInstance: aModelInstance [

	self data remove: aModelInstance.
	self refresh
]

{ #category : #rendering }
TBTableView >> renderContentOn: html [

	html mdlTable shadow: 2; "selectable;" with: [ 
		self renderTableOn: html ]
]

{ #category : #actions }
TBTableView >> viewInstance: aModelInstance [

	self
		show: (self
			buildViewerFor: aModelInstance
			titled: aModelInstance mdlDisplayString)
		onAnswer: [ self refresh ]
]

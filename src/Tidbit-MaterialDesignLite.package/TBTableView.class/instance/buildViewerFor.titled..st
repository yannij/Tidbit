actions
buildViewerFor: anObject titled: aString

	^ anObject asComponent
		addMessage: aString;
		yourself
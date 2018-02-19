actions
buildViewerFor: anObject titled: aString

	^ anObject asComponent
		addSwitch;
		addMessage: aString;
		yourself
Class {
	#name : #TBToolNav,
	#superclass : #MDLWidget,
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #rendering }
TBToolNav >> actions [

	^{
		'ToolNav1' -> [ self session presenter switchToHome ].
		'ToolNav2' -> [ self session presenter switchToHome ].
		'ToolNav3' -> [ self session presenter switchToHome ].
	}

]

{ #category : #rendering }
TBToolNav >> renderContentOn: html [

	self renderLayoutHeaderOn: html
]

{ #category : #rendering }
TBToolNav >> renderLayoutHeaderOn: html [

	html mdlLayout
		fixedHeader;
		with: [
			html mdlLayoutHeader: [ 
				html mdlLayoutHeaderRow: [
					html mdlLayoutSpacer.
					self renderNavigationOn: html ] ] ]
]

{ #category : #rendering }
TBToolNav >> renderNavigationOn: html [

	html mdlNavigation: [ 
		self actions do: [ :each |
			html mdlNavigationLink
				onClick: ((html jQuery ajax)
						callback: each value;
						onComplete: html javascript refresh;
						yourself);
					yourself;
				with: each key ] ]

]

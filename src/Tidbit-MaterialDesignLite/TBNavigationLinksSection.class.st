Class {
	#name : #TBNavigationLinksSection,
	#superclass : #MDLAbstractLayoutSection,
	#instVars : [
		'links'
	],
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #initalize }
TBNavigationLinksSection >> initialize [
	super initialize.
	links := OrderedCollection new.
]

{ #category : #accessing }
TBNavigationLinksSection >> links [
	^ links
]

{ #category : #accessing }
TBNavigationLinksSection >> links: anObject [
	links := anObject
]

{ #category : #accessing }
TBNavigationLinksSection >> renderContentOn: html [

	html mdlLayoutDrawer: [ 
		"html mdlLayoutTitle: layout title."
		"html mdlLayoutTitle: title."
		self renderLinksOn: html.
		"self renderLinksToRecentOn: html."
	]
]

{ #category : #rendering }
TBNavigationLinksSection >> renderLinksOn: html [

	self links do: [ :eachLinkGroup | 
		html mdlNavigation: [ 
			eachLinkGroup do: [ :each | | label callback |
				label := each key.
				callback := each value.
				html mdlNavigationLink callback: callback; with: label ] ].
		"html mdlLayoutSpacer" ].

]

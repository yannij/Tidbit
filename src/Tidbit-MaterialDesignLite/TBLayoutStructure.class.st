Class {
	#name : #TBLayoutStructure,
	#superclass : #WAComponent,
	#instVars : [
		'appBar',
		'contentArea',
		'sideNav',
		'rightNav',
		'bottomBar'
	],
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #'instance creation' }
TBLayoutStructure class >> withConfiguration: aDictionary [

	^self new
		build: aDictionary;
		yourself
]

{ #category : #'initailize-release' }
TBLayoutStructure >> build: aDictionary [
	| screenLayout |

	screenLayout := MDLLayoutWidget new title: 'ToDo'; yourself.

	(aDictionary at: 'sideNav' ifAbsent: [ true ])
		ifTrue: [
			screenLayout
				drawerSection: self buildDrawer;
				fixedDrawer].

	screenLayout
		headerSection: TBHeaderSection new;
		fixedHeader.

	self addDecoration: (MDLScreenLayout newWithLayout: screenLayout).

]

{ #category : #'initailize-release' }
TBLayoutStructure >> buildDrawer [

	^ TBNavigationLinksSection new
		links: (OrderedCollection new
			add: (OrderedCollection new
				add: 'Home' -> [ self session presenter switchToHome ];
				add: 'Recent' -> [ self session presenter switchToRecent ];
				add: 'Favs' -> [ self session presenter switchToFavs ];
				yourself);
			yourself);
		yourself
]

{ #category : #'initailize-release' }
TBLayoutStructure >> initialize [

	super initialize.

	"self addDecoration: (MDLScreenLayout newWithLayout: self buildLayout)."

]

{ #category : #rendering }
TBLayoutStructure >> renderContentAndRightNavOn: html [

	html mdlLayoutContent
		style: 'width: 100%';
		with: [
		html mdlGrid
			class: 'mdl-layout--small-screen-only';
			class: 'mdl-grid--no-spacing';
			with: [ 
				html mdlCell size: 12; with: [ html render: (TBToolNav new) ].
			].
		html mdlGrid
			class: 'mdl-grid--no-spacing';
			with: [ 
				html mdlCell
					size: 10; stretch;
					with: [ 
						html mdlCard
							style: 'overflow-x: auto; width: 100%;';
							with: [ html render: self session presenter view ] ].
				self renderRightNavCellOn: html.
		] ].
]

{ #category : #rendering }
TBLayoutStructure >> renderContentOn: html [

	html div
		style: 'min-height: 400px';
		with: [self renderContentAndRightNavOn: html].

]

{ #category : #rendering }
TBLayoutStructure >> renderRightNavCellOn: html [

		html mdlCell
			hidePhone;
			size: 2; stretch;
			with: [ 
				html mdlCard
					style: 'overflow-x: auto; width: 100%;';
					with: [ self renderRightNavDivOn: html ] ].

]

{ #category : #rendering }
TBLayoutStructure >> renderRightNavDivOn: html [
	| divId |

	divId := html nextId.
	html div
		style: 'text-align: left; display:flex;height: 600px; background-color: #CFD8DC;';
		shadow: 2;
		with: [ 
			html render:
				((MDLNestedList
					elements: self rightNavLinks
					children: [:ignored |  #() ])
					format: #key;
					actionBlock: [:element | element value value ]
					yourself).
			html div id: divId ]
]

{ #category : #rendering }
TBLayoutStructure >> rightNavLinks [
	| quickLinks |

	quickLinks := (OrderedCollection new
				add: 'RightNav1' -> [ self session presenter switchToHome ];
				add: 'RightNav2' -> [ self session presenter switchToHome ];
				add: 'RightNav3' -> [ self session presenter switchToHome ];
				add: 'RightNav4' -> [ self session presenter switchToHome ];
				yourself).

	^quickLinks
]

Class {
	#name : #TBToDoApplication,
	#superclass : #MCWResponsiveApplication,
	#category : 'Tidbit-MaterialComponentsWeb'
}

{ #category : #'class initialization' }
TBToDoApplication class >> applicationPath [

	^'tidbit/todo'

]

{ #category : #'class initialization' }
TBToDoApplication class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self registerToDevelopment: self applicationPath

]

{ #category : #actions }
TBToDoApplication >> addToRecent: anObject [
]

{ #category : #initialization }
TBToDoApplication >> appBarTitle [

	^self applicationTitle 

]

{ #category : #accessing }
TBToDoApplication >> applicationTitle [

	^'Tidbit ToDo'
]

{ #category : #accessing }
TBToDoApplication >> browserTabTitle [

	^self headerTitle

]

{ #category : #initialization }
TBToDoApplication >> buildMainFab [

	^nil
]

{ #category : #initialization }
TBToDoApplication >> buildSideNavList [

	^MCWListBasic new
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: [self sideNav menuItemCallback]);
		addListItem: (MCWListItemIcon  itemText: 'Recent' iconName: 'history' callback: [self sideNav menuItemCallback]);
		addListItem: (MCWListItemIcon  itemText: 'Favs' iconName: 'favorite' callback: [self sideNav menuItemCallback]);
		yourself.

]

{ #category : #accessing }
TBToDoApplication >> canvas [

	^self layout contentArea component
]

{ #category : #actions }
TBToDoApplication >> favCurrentObject [
]

{ #category : #'accessing - model' }
TBToDoApplication >> getSessionUser [

	^self session properties at: #user ifAbsent: [ nil ]

]

{ #category : #accessing }
TBToDoApplication >> headerTitle [

	^'(Tidbit-ToDo2)'
]

{ #category : #initialization }
TBToDoApplication >> initialize [

	super initialize.

	self settings setFont: MCWGoogleFont allAvailable atRandom.
	self layout contentArea component: TBContentGrid new.

	self setSessionUser: self retrieveTestModel.
	self setViewOn: self getSessionUser.

	self applicationPostInitialize: self

]

{ #category : #actions }
TBToDoApplication >> removeFromRecentlyViewed: anObject [
]

{ #category : #'accessing - model' }
TBToDoApplication >> retrieveTestModel [

	^(TBExampleDatabase repository selectAll: TBUser)
		ifEmpty: [nil]
		ifNotEmpty: [:value | value anyOne]
]

{ #category : #'accessing - model' }
TBToDoApplication >> saveObject: anObject [

	TBExampleDatabase repository save: anObject
]

{ #category : #initialization }
TBToDoApplication >> setCanvasContent2: aModel [
	| newView |

	aModel isNil
		ifTrue: [ ^self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self canvas content2: newView.

]

{ #category : #'accessing - model' }
TBToDoApplication >> setSessionUser: aUser [

	self session properties at: #user put: aUser.

]

{ #category : #initialization }
TBToDoApplication >> setViewOn: aModel [
	| newView |

	aModel isNil
		ifTrue: [ ^self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self layout contentArea component content1: newView.

]

{ #category : #actions }
TBToDoApplication >> switchToFavs [

	"self setViewOn: 'Favs'"
]

{ #category : #actions }
TBToDoApplication >> switchToHome [

	"self setViewOn: 'Recent'"
]

{ #category : #actions }
TBToDoApplication >> switchToRecent [

	"self setViewOn: 'Recent'"
]

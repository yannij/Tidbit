Class {
	#name : #TBToDoApplication,
	#superclass : #MCWResponsiveApplication,
	#instVars : [
		'viewUser',
		'viewTask'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
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
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: [self setView: self viewUser]);
		addListItem: (MCWListItemIcon  itemText: 'Tasks' iconName: 'history' callback: [self setView: self viewTask]);
		yourself.

]

{ #category : #accessing }
TBToDoApplication >> headerTitle [

	^'(Tidbit-ToDo2)'
]

{ #category : #initialization }
TBToDoApplication >> initialize [

	self sessionUserSet: self retrieveTestModel.
	self viewUser: TBContentGrid new.
	self viewTask: TBViewTask new.

	super initialize.

	"self settings setFont: MCWGoogleFont allAvailable atRandom."
	self layout contentArea component: self viewUser.

	self setViewOn: self sessionUserGet.

	self applicationPostInitialize: self

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

{ #category : #'accessing - model' }
TBToDoApplication >> sessionUserGet [

	^self session properties at: #user ifAbsent: [ nil ]
]

{ #category : #'accessing - model' }
TBToDoApplication >> sessionUserSet: aUser [

	self session properties at: #user put: aUser
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

	self viewUser content2: newView.

]

{ #category : #initialization }
TBToDoApplication >> setView: aView [

	self layout contentArea component: aView
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

	self viewUser content1: newView.

]

{ #category : #accessing }
TBToDoApplication >> viewTask [
	^ viewTask
]

{ #category : #accessing }
TBToDoApplication >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #accessing }
TBToDoApplication >> viewUser [
	^ viewUser
]

{ #category : #accessing }
TBToDoApplication >> viewUser: anObject [
	viewUser := anObject
]

Class {
	#name : #TBToDoApplication,
	#superclass : #MCWResponsiveApplication,
	#instVars : [
		'viewUser',
		'viewTask',
		'viewTaskFilter'
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

	^ self registerMaterialWebDevelopment: self applicationPath

]

{ #category : #initialization }
TBToDoApplication >> appBarTitle [

	^ self applicationTitle 

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

	^ MCWListBasic new
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: [self viewUserGo]);
		addListItem: (MCWListItemIcon  itemText: 'Tasks' iconName: 'checklist' callback: [self viewTaskGo]);
		yourself
]

{ #category : #initialization }
TBToDoApplication >> buildSideSheet [

	^ MCWSideSheet new
]

{ #category : #accessing }
TBToDoApplication >> headerTitle [

	^'(Tidbit-ToDo2)'
]

{ #category : #initialization }
TBToDoApplication >> initialize [

	self applicationRootSet: self.
	self sessionUserSet: self retrieveTestModel.
	self viewUser: TBContentGrid new.
	self viewTask: TBViewTask new.
	self viewTaskFilter: TBViewTaskFilter new.

	super initialize.
	self layout sideSheet beHidden.

	"self settings setFont: MCWGoogleFont allAvailable atRandom."
	self layout contentArea component: self viewUser.
	self layout sideSheet component: self viewTaskFilter.

	self viewUserSetTo: self sessionUserGet.

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

{ #category : #navigation }
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

{ #category : #accessing }
TBToDoApplication >> viewTask [
	^ viewTask
]

{ #category : #accessing }
TBToDoApplication >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #accessing }
TBToDoApplication >> viewTaskFilter [
	^ viewTaskFilter
]

{ #category : #accessing }
TBToDoApplication >> viewTaskFilter: anObject [
	viewTaskFilter := anObject
]

{ #category : #navigation }
TBToDoApplication >> viewTaskGo [

	self layout contentArea component: self viewTask.
	self layout sideSheet beUnHidden
]

{ #category : #accessing }
TBToDoApplication >> viewUser [
	^ viewUser
]

{ #category : #accessing }
TBToDoApplication >> viewUser: anObject [
	viewUser := anObject
]

{ #category : #navigation }
TBToDoApplication >> viewUserGo [

	self layout contentArea component: self viewUser.
	self layout sideSheet beHidden
]

{ #category : #navigation }
TBToDoApplication >> viewUserSetTo: aModel [
	| newView |

	aModel isNil ifTrue: [ ^self ].
	newView := aModel asComponent addValidatedForm; yourself.
	self viewUser content1: newView
]

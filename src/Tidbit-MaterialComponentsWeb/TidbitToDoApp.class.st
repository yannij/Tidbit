Class {
	#name : #TidbitToDoApp,
	#superclass : #MCWResponsiveApplication,
	#instVars : [
		'viewUser',
		'viewTask',
		'viewTaskFilter'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #'class initialization' }
TidbitToDoApp class >> applicationPath [

	^ 'tidbit/todo'

]

{ #category : #'class initialization' }
TidbitToDoApp class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self registerMaterialWebDeployment: self applicationPath

]

{ #category : #initialization }
TidbitToDoApp >> appBarTitle [

	^ self applicationTitle 

]

{ #category : #accessing }
TidbitToDoApp >> applicationTitle [

	^ 'Tidbit ToDo'
]

{ #category : #accessing }
TidbitToDoApp >> browserTabTitle [

	^ self headerTitle

]

{ #category : #initialization }
TidbitToDoApp >> buildMainFab [

	^ nil
]

{ #category : #initialization }
TidbitToDoApp >> buildSideNavList [

	^ MCWListBasic new
		addListItem: (MCWListItemIcon  itemText: 'Home' iconName: 'home' callback: [ self viewUserGo ]);
		addListItem: (MCWListItemIcon  itemText: 'Tasks' iconName: 'checklist' callback: [ self viewTaskGo ]);
		yourself
]

{ #category : #initialization }
TidbitToDoApp >> buildSideSheet [

	^ MCWSideSheet new
]

{ #category : #accessing }
TidbitToDoApp >> headerTitle [

	^ '(Tidbit-ToDo2)'
]

{ #category : #initialization }
TidbitToDoApp >> initialize [

	self applicationRootSet: self.
	self viewUser: TidbitViewGridContent new.
	self viewUser content1: nil.
	self viewTask: TidbitViewTask new.
	self viewTaskFilter: TidbitViewTaskFilter new.

	super initialize.
	self layout sideSheet beHidden.

	"self settings setFont: MCWGoogleFont allAvailable atRandom."
	self layout contentArea component: self viewUser.
	self layout sideSheet component: self viewTaskFilter.
	self loginComponent: (MCWLogin new
			loginTitle: self applicationTitle;
			authenticationBlock: [ :loginId :password |
				| userOrNil |
				userOrNil := TidbitExampleDatabase authenticatedUser: loginId password: password.
				"userOrNil := TidbitExampleDatabase findUser: 'demo'."
				self sessionUserSet: userOrNil.
				self viewUserSetTo: userOrNil ];
			yourself).

	self applicationPostInitialize: self

]

{ #category : #'accessing - model' }
TidbitToDoApp >> saveObject: anObject [

	TidbitExampleDatabase repository save: anObject
]

{ #category : #navigation }
TidbitToDoApp >> setCanvasContent2: aModel [
	| newView |

	aModel ifNil: [ ^ self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self viewUser content2: newView.

]

{ #category : #accessing }
TidbitToDoApp >> viewTask [
	^ viewTask
]

{ #category : #accessing }
TidbitToDoApp >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #accessing }
TidbitToDoApp >> viewTaskFilter [
	^ viewTaskFilter
]

{ #category : #accessing }
TidbitToDoApp >> viewTaskFilter: anObject [
	viewTaskFilter := anObject
]

{ #category : #navigation }
TidbitToDoApp >> viewTaskGo [

	self layout contentArea component: self viewTask.
	self layout sideSheet beUnHidden
]

{ #category : #accessing }
TidbitToDoApp >> viewUser [
	^ viewUser
]

{ #category : #accessing }
TidbitToDoApp >> viewUser: anObject [
	viewUser := anObject
]

{ #category : #navigation }
TidbitToDoApp >> viewUserGo [

	self layout contentArea component: self viewUser.
	self layout sideSheet beHidden
]

{ #category : #navigation }
TidbitToDoApp >> viewUserSetTo: aModel [
	| newView |

	aModel ifNil: [
		self viewUser content1: nil.
		^ self ].

	newView := aModel asComponent addValidatedForm; yourself.
	self viewUser content1: newView
]

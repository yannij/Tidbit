Class {
	#name : #TidbitToDoApp,
	#superclass : #MCWResponsiveApplication,
	#instVars : [
		'viewMap',
		'viewUser',
		'viewUsers',
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

	^ self mcwRegisterDeployment: self applicationPath
]

{ #category : #initialization }
TidbitToDoApp >> appBarTitle [

	^ self applicationTitle 

]

{ #category : #accessing }
TidbitToDoApp >> applicationTitle [

	^ 'Tidbit ToDo'
]

{ #category : #'utility - login' }
TidbitToDoApp >> authenticateUsername: aUsername password: aPassword [
	"Answer a user instance if hashed pssword matches saved passwrodHass,
	or answer nil is does not match, or user not found"

	^ (self findUser: aUsername)
		ifNil: [ nil ]
		ifNotNil: [ :value |
			value passwordHash = (MCWLogin passwordHashFor: (aPassword ifNil: [ '' ] ifNotNil: [ :arg | arg ]))
				ifTrue: [ value ]
				ifFalse: [ nil ] ]
]

{ #category : #accessing }
TidbitToDoApp >> browserTabTitle [

	^ self headerTitle

]

{ #category : #initialization }
TidbitToDoApp >> buildLoginComponent [

	^ MCWLogin new
		loginTitle: self applicationTitle;
		authenticationBlock: [ :username :password |
			| userOrNil |
			userOrNil := self authenticateUsername: username password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		recoverBlock: [ :username :tokenTyped :tokenSent |
			| userOrNil |
			self logFormat: 'Recovering: tokenTyped="{1}", tokenSent="{2}"' with: tokenTyped with: tokenSent.
			userOrNil := nil.
			tokenTyped = tokenSent ifTrue: [
				userOrNil := self findUser: username ].
			self viewUserSetTo: userOrNil.
			userOrNil ];
		registerBlock: [ :username :password |
			| userOrNil |
			self logFormat: 'Registering username="{1}"' with: username.
			userOrNil := self registerUsername: username password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		sendTokenBlock: [ :username |
			self logFormat: 'Sending token to username="{1}"' with: username.
			'1234' ];
		yourself
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
		addListItem: (MCWListItemIcon  itemText: 'Users' iconName: 'perm_identity' callback: [ self viewUsersGo ]);
		addListItem: (MCWListItemIcon  itemText: 'Tools' iconName: 'build_circle' callback: [ self viewToolsGo ]);
		yourself
]

{ #category : #initialization }
TidbitToDoApp >> buildSideSheet [

	^ MCWSideSheet new
]

{ #category : #'utility - login' }
TidbitToDoApp >> findUser: aUsername [
	"Answer the user having username matching aUsername, or nil if not found"

	^ (self repository selectAll: TidbitUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser username = aUsername ] ifNone: [ nil ] ]
]

{ #category : #accessing }
TidbitToDoApp >> headerTitle [

	^ '(Tidbit-ToDo2)'
]

{ #category : #initialization }
TidbitToDoApp >> initialize [

	self viewMap: IdentityDictionary new.
	self viewUser: TidbitViewGridContent new.
	self viewUser content1: nil.
	self viewUsers: TidbitViewUsers new.
	self viewTask: TidbitViewTask new.
	self viewTaskFilter: TidbitViewTaskSideSheet new.
	self viewMapAt: #Tools put: TidbitViewTools new.

	super initialize.
	self layout sideSheet beHidden.

	"self settings setFont: MCWGoogleFont allAvailable atRandom."
	self layout contentArea component: self viewUser.
	self layout sideSheet component: self viewTaskFilter.
	self loginComponent: self buildLoginComponent.

	self applicationPostInitialize: self

]

{ #category : #'utility - login' }
TidbitToDoApp >> newUsername: aUsername password: aPassword [
	| userModel |

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername;
		passwordHash: (MCWLogin passwordHashFor: aPassword);
		yourself.

	self repository save: userModel.

	^ userModel

]

{ #category : #'utility - login' }
TidbitToDoApp >> registerUsername: aUsername password: aPassword [
	"Answer a new user instance built from the userId/password,
	or answer nil user already exists"

	^ (self findUser: aUsername)
		ifNil: [ self newUsername: aUsername password: aPassword ]
		ifNotNil: [ :value | "User already exists" nil ]
]

{ #category : #'utility - repository' }
TidbitToDoApp >> repository [

	"^ TidbitExampleDatabase memory1"
	^ VORepository current
]

{ #category : #'utility - repository' }
TidbitToDoApp >> repositoryClear [
	"Do nothing for memory repository"
]

{ #category : #'utility - repository' }
TidbitToDoApp >> repositoryReset [

	TidbitExampleDatabase repositorySetUpMemorySingleton
]

{ #category : #'accessing - model' }
TidbitToDoApp >> saveObject: anObject [

	self mcwApplicationGet repository save: anObject
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
TidbitToDoApp >> viewMap [
	^ viewMap
]

{ #category : #accessing }
TidbitToDoApp >> viewMap: anObject [
	viewMap := anObject
]

{ #category : #accessing }
TidbitToDoApp >> viewMapAt: aKey [

	self viewMapAt: aKey ifAbsent: [ nil ]
]

{ #category : #accessing }
TidbitToDoApp >> viewMapAt: aKey ifAbsent: aBlock [

	self viewMap at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
TidbitToDoApp >> viewMapAt: aKey put: aContentArea [

	self viewMap at: aKey put: aContentArea
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

{ #category : #navigation }
TidbitToDoApp >> viewToolsGo [

	self layout contentArea component: (self viewMap at: #Tools).
	self layout sideSheet beHidden
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
TidbitToDoApp >> viewUserModel [

	^ self viewUser content1
		ifNil: [ nil ]
		ifNotNil: [ :value | value model ]
]

{ #category : #navigation }
TidbitToDoApp >> viewUserSetTo: aModel [
	| newView |

	aModel ifNil: [
		self viewUser content1: nil.
		^ self ].

	newView := aModel asComponent addValidatedForm; yourself.
	self viewUser content1: newView.
	self viewUserGo
]

{ #category : #accessing }
TidbitToDoApp >> viewUsers [
	^ viewUsers
]

{ #category : #accessing }
TidbitToDoApp >> viewUsers: anObject [
	viewUsers := anObject
]

{ #category : #navigation }
TidbitToDoApp >> viewUsersGo [

	self layout contentArea component: self viewUsers.
	self layout sideSheet beHidden
]

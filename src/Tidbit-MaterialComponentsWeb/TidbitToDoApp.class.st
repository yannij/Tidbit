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

{ #category : #'utility - login' }
TidbitToDoApp class >> authenticatedUser: aUserId password: aPassword [
	"Answer a user instance if hashed pssword matches saved passwrodHass,
	or answer nil is does not match, or user not found"

	^ (self findUser: aUserId)
		ifNil: [ nil ]
		ifNotNil: [ :value |
			value passwordHash = (MCWLogin passwordHashFor: (aPassword ifNil: [ '' ] ifNotNil: [ :arg | arg ]))
				ifTrue: [ value ]
				ifFalse: [ nil ] ]
]

{ #category : #'utility - login' }
TidbitToDoApp class >> findUser: aUsername [
	"Answer the user having userId matching aUsername, or nil if not found"

	^ (VORepository current selectAll: TidbitUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser username = aUsername ] ifNone: [ nil ] ]
]

{ #category : #'class initialization' }
TidbitToDoApp class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self registerMaterialWebDeployment: self applicationPath

]

{ #category : #'utility - login' }
TidbitToDoApp class >> newUserId: aUsername password: aPassword [
	| userModel |

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername;
		passwordHash: (MCWLogin passwordHashFor: aPassword);
		yourself.

	VORepository current save: userModel.

	^ userModel

]

{ #category : #'utility - login' }
TidbitToDoApp class >> registerUser: aUserId password: aPassword [
	"Answer a new user instance built from the userId/password,
	or answer nil user already exists"

	^ (self findUser: aUserId)
		ifNil: [ self newUserId: aUserId password: aPassword ]
		ifNotNil: [ :value | "User already exists" nil ]
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
TidbitToDoApp >> buildLoginComponent [

	^ MCWLogin new
		loginTitle: self applicationTitle;
		authenticationBlock: [ :loginId :password |
			| userOrNil |
			userOrNil := self class authenticatedUser: loginId password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		recoverBlock: [ :loginId :tokenTyped :tokenSent |
			| userOrNil |
			self logFormat: 'Recovering: tokenTyped="{1}", tokenSent="{2}"' with: tokenTyped with: tokenSent.
			userOrNil := nil.
			tokenTyped = tokenSent ifTrue: [
				userOrNil := self class findUser: loginId ].
			self viewUserSetTo: userOrNil.
			userOrNil ];
		registerBlock: [ :loginId :password |
			| userOrNil |
			self logFormat: 'Registering loginId="{1}"' with: loginId.
			userOrNil := self class registerUser: loginId password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		sendTokenBlock: [ :loginId |
			self logFormat: 'Sending token to loginId="{1}"' with: loginId.
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

	self viewUser: TidbitViewGridContent new.
	self viewUser content1: nil.
	self viewTask: TidbitViewTask new.
	self viewTaskFilter: TidbitViewTaskFilter new.

	super initialize.
	self layout sideSheet beHidden.

	"self settings setFont: MCWGoogleFont allAvailable atRandom."
	self layout contentArea component: self viewUser.
	self layout sideSheet component: self viewTaskFilter.
	self loginComponent: self buildLoginComponent.

	self applicationPostInitialize: self

]

{ #category : #'accessing - model' }
TidbitToDoApp >> saveObject: anObject [

	VORepository current save: anObject
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
	self viewUser content1: newView
]

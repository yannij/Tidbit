Class {
	#name : #TBExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Repository'
	],
	#category : #'Tidbit-Core'
}

{ #category : #'utility - password' }
TBExampleDatabase class >> authenticatedUser: aUserId password: aPassword [
	"Answer a user instance if hashed pssword matches saved passwrodHass,
	or answer nil is does not match, or user not found"

	^ (self findUser: aUserId)
		ifNil: [ nil ]
		ifNotNil: [ :value |
			value passwordHash = (MCWLogin passwordHashFor: (aPassword ifNil: [ '' ] ifNotNil: [ :arg | arg ]))
				ifTrue: [ value ]
				ifFalse: [ nil ] ]
]

{ #category : #initalize }
TBExampleDatabase class >> buildTestDatabase [
	"
	self repositoryClear.
	self buildTestDatabase.
	"

	self buildUserDemo.
	self buildUserGuest
]

{ #category : #initalize }
TBExampleDatabase class >> buildUserDemo [
	| userModel |

	userModel := TBUser new
		userId: 'demo';
		firstName: 'Demo';
		lastName: 'User';
		passwordHash: (MCWLogin passwordHashFor: 'secret');
		yourself.

	userModel
		toDoItemsAdd: (TBToDoItem new summary: 'foobar-1'; priority: 1; colorCode: (Color indexedColors at: 8); done: true; yourself);
		toDoItemsAdd: (TBToDoItem new summary: 'foobar-2'; priority: 2; colorCode: (Color indexedColors at: 9); description: self loremText; yourself).

	self repository save: userModel.

	^ userModel

]

{ #category : #initalize }
TBExampleDatabase class >> buildUserGuest [
	"
	self repositoryClear.
	self buildTestDatabase.
	"
	| userModel |

	userModel := TBUser new
		userId: 'guest';
		firstName: 'Guest';
		lastName: 'User';
		passwordHash: (MCWLogin passwordHashFor: 'secret');
		yourself.

	userModel
		toDoItemsAdd: (TBToDoItem new summary: 'todo-1'; priority: 1; colorCode: (Color indexedColors at: 4); yourself);
		toDoItemsAdd: (TBToDoItem new summary: 'todo-2'; priority: 2; colorCode: (Color indexedColors at: 5); description: self loremText; yourself);
		toDoItemsAdd: (TBToDoItem new summary: 'todo-3'; priority: 3; colorCode: (Color indexedColors at: 6); done: true; yourself);
		toDoItemsAdd: (TBToDoItem new summary: 'todo-4'; priority: 4; colorCode: (Color indexedColors at: 7); yourself).

	self repository save: userModel.

	^ userModel

]

{ #category : #'utility - password' }
TBExampleDatabase class >> findUser: aUserId [
	"Answer the user having userId matching aUserId, or nil if not found"

	^ (TBExampleDatabase repository selectAll: TBUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser userId = aUserId ] ifNone: [ nil ] ]
]

{ #category : #'class initialization' }
TBExampleDatabase class >> initialize [

	self repositoryClear.
	self buildTestDatabase.
	Smalltalk addToShutDownList: self
]

{ #category : #initalize }
TBExampleDatabase class >> loremText [

	^ 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
]

{ #category : #initalize }
TBExampleDatabase class >> repository [

	Repository ifNil: [ Repository := VOMemoryRepository new ].
	^ Repository

]

{ #category : #initalize }
TBExampleDatabase class >> repositoryClear [
	"
	self repositoryClear
	"

	Repository ifNotNil: [ :arg |
		"Repository database close."
		Repository := nil ]

]

{ #category : #initalize }
TBExampleDatabase class >> repositoryName [

	^ 'TidbitExample'

]

{ #category : #'system startup' }
TBExampleDatabase class >> shutDown: quitting [
	
	"self repositoryClear."

]

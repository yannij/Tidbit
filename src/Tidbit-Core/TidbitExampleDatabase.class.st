Class {
	#name : #TidbitExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Memory1',
		'Memory2',
		'Mongo1'
	],
	#category : #'Tidbit-Core'
}

{ #category : #initalize }
TidbitExampleDatabase class >> buildUser: aUsername [

	self buildUser: aUsername repository: VORepository current
]

{ #category : #initalize }
TidbitExampleDatabase class >> buildUser: aUsername repository: aRepository [
	| userModel itemCount today |

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername capitalized, ' Test';
		email: aUsername, '@foo.com';
		website: 'foo.com/', aUsername;
		passwordHash: (MCWLogin passwordHashFor: 'secret');
		yourself.

	today := Date today.
	itemCount := 10 atRandom - 1.
	itemCount timesRepeat: [
		| priority todoItem |
		priority := 100 atRandom.
		todoItem := TidbitToDoItem new
			summary: 'task ', priority printString;
			priority: priority;
			completeByDate: (today addDays: priority - 30);
			completeByTime: (Time fromSeconds: (17 + 16 atRandom) * 60 * 30);
			estimatedDuration: (Duration minutes: ((12 atRandom) * 15));
			colorCode: (Color indexedColors at: 256 atRandom);
			yourself.
		(priority \\ 3) isZero ifTrue: [ todoItem done: true ].
		(priority \\ 5) isZero ifTrue: [ todoItem description: self loremText ].
		todoItem save.
		userModel toDoItemsAdd: todoItem ].

	aRepository save: userModel.

	^ userModel

]

{ #category : #initalize }
TidbitExampleDatabase class >> buildUserDemo [
	| userModel |

	userModel := TidbitUser new
		username: 'demo';
		fullName: 'Demo User';
		passwordHash: (MCWLogin passwordHashFor: 'secret');
		yourself.

	userModel
		toDoItemsAdd: (TidbitToDoItem new summary: 'foobar-1'; priority: 1; colorCode: (Color indexedColors at: 8); done: true; yourself);
		toDoItemsAdd: (TidbitToDoItem new summary: 'foobar-2'; priority: 2; colorCode: (Color indexedColors at: 9); description: self loremText; yourself).

	VORepository current save: userModel.

	^ userModel

]

{ #category : #initalize }
TidbitExampleDatabase class >> buildUserGuest [
	| userModel |

	userModel := TidbitUser new
		username: 'guest';
		fullName: 'Guest User';
		passwordHash: (MCWLogin passwordHashFor: 'secret');
		yourself.

	userModel
		toDoItemsAdd: (TidbitToDoItem new summary: 'todo-1'; priority: 1; colorCode: (Color indexedColors at: 4); yourself);
		toDoItemsAdd: (TidbitToDoItem new summary: 'todo-2'; priority: 2; colorCode: (Color indexedColors at: 5); description: self loremText; yourself);
		toDoItemsAdd: (TidbitToDoItem new summary: 'todo-3'; priority: 3; colorCode: (Color indexedColors at: 6); done: true; yourself);
		toDoItemsAdd: (TidbitToDoItem new summary: 'todo-4'; priority: 4; colorCode: (Color indexedColors at: 7); yourself).

	VORepository current save: userModel.

	^ userModel

]

{ #category : #'class initialization' }
TidbitExampleDatabase class >> initialize [

	self repositorySetUpMemorySingleton
]

{ #category : #initalize }
TidbitExampleDatabase class >> loremText [

	^ 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory1 [
	^ Memory1
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory1: anObject [
	Memory1 := anObject
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory1Clear [

	Memory1 := nil
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory2 [
	^ Memory2
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory2: anObject [
	Memory2 := anObject
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory2Clear [

	Memory2 := nil
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongo1 [
	^ Mongo1
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongo1: anObject [
	Mongo1 := anObject
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongo1Clear [

	Mongo1 := nil
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMemory1 [
	"
	self memory1Clear.
	self repositorySetUpMemory1.
	"

	self memory1: VOMemoryRepository new.

	1 to: 10 do: [ :index | self buildUser: 'a', index printString repository: self memory1 ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMemory2 [
	"
	self memory2Clear.
	self repositorySetUpMemory2.
	"

	self memory2: VOMemoryRepository new.

	1 to: 10 do: [ :index | self buildUser: 'b', index printString repository: self memory2 ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMemorySingleton [
	"
	self repositorySetUpMemorySingleton
	"
	| repository |

	VORepository current ifNotNil: [ :value | value reset ].
	repository := VOMemoryRepository new.
	repository enableSingleton.

	self buildUserDemo.
	self buildUserGuest.
	1 to: 10 do: [ :index |
		self buildUser: 'user', index printString ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMongo1 [
	"
	self repositorySetUpMongo1.
	"

	self repositorySetUpMongo1Host: VOMongoRepository defaultHost port: VOMongoRepository defaultPort
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMongo1Host: aHostname port: aPortno [
	"
	self mongo1Clear.
	self repositorySetUpMongo1Host: VOMongoRepository defaultHost port: VOMongoRepository defaultPort.
	"
	| mongo |

	mongo := (VOMongoRepository host: aHostname port: aPortno database: 'Tidbit').

	1 to: 10 do: [ :index | self buildUser: 'mongo', index printString repository: mongo ]
]

Class {
	#name : #TidbitExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Memory1',
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
	| userModel itemCount today importance |

	importance := TidbitToDoItem importanceValues.

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername capitalized, ' Test';
		email: aUsername, '@foo.com';
		website: 'http://foo.com/', aUsername;
		passwordHash: (MCWLogin passwordHashFor: 'secret');
		yourself.

	today := Date today.
	itemCount := 25 atRandom.
	1 to: itemCount do: [ :index |
		| priority todoItem |
		priority := 100 atRandom.
		todoItem := TidbitToDoItem new
			summary: 'task ', index printString;
			priority: priority;
			importance: (importance at: (priority \\ 3) + 1);
			completeByDate: (today addDays: priority - 30);
			completeByTime: (Time fromSeconds: (17 + 16 atRandom) * 60 * 30);
			estimatedDuration: (Duration minutes: ((12 atRandom) * 15));
			colorCode: (Color indexedColors at: 256 atRandom);
			yourself.
		(priority \\ 2) isZero ifTrue: [ todoItem done: true ].
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

	^ String loremIpsum truncateTo: 123
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
TidbitExampleDatabase class >> mongo1 [
	^ Mongo1
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongo1: anObject [
	Mongo1 := anObject
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongo1RecreateTestData [
	"
	self mongo1ResetConnection; mongo1RecreateTestData
	"

	self mongo1 ifNil: [
		"TODO: log an error"
		^ self ].

	self mongoRepositorySetUp: self mongo1
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongo1ResetConnection [

	Mongo1 := self mongoRepositoryBuild
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongoDatabase [

	^ DockerDeploy current mongoDatabaseDefault
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongoHost [

	^ DockerDeploy current mongoHostDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultHost ]
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongoPort [

	^ DockerDeploy current mongoPortDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultPort ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongoRepositoryBuild [
	| mongo username pwd |

	username := DockerDeploy current secretsAt: DockerDeploy defaultMongoSecretName atKey: 'mongo-username'.
	(username isNil or: [ username isEmpty ]) ifTrue: [
		^ self error: 'mongo-username is nil or empty' ].
	pwd := DockerDeploy current secretsAt: DockerDeploy defaultMongoSecretName atKey: 'mongo-password'.
	(pwd isNil or: [ pwd isEmpty ]) ifTrue: [
		^ self error: 'mongo-password is nil or empty' ].

	mongo := VOMongoRepository
		host: self mongoHost
		port: self mongoPort
		database: self mongoDatabase
		username: username
		password: pwd.

	^ mongo
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongoRepositorySetUp: aMongoRepository [
	"
	self mongo1Clear.
	self repositorySetUpMongo: self mongoRepositoryBuild.
	"

	aMongoRepository removeAll: TidbitUser.
	aMongoRepository removeAll: TidbitToDoItem.

	1 to: 10 do: [ :index | self buildUser: 'mongo', index printString repository: aMongoRepository ]
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

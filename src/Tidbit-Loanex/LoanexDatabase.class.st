Class {
	#name : #LoanexDatabase,
	#superclass : #Object,
	#classVars : [
		'Memory1',
		'Mongo1'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #initalize }
LoanexDatabase class >> buildUser: aUsername [

	self buildUser: aUsername repository: VORepository current
]

{ #category : #initalize }
LoanexDatabase class >> buildUser: aUsername repository: aRepository [
	| userModel itemCount today importance |

	importance := LoanexToy importanceValues.

	userModel := LoanexUser new
		username: aUsername;
		fullName: aUsername capitalized, ' Test';
		email: aUsername, '@foo.com';
		website: 'http://foo.com/', aUsername;
		passwordHash: (MDSLogin passwordHashFor: 'secret');
		yourself.

	today := Date today.
	itemCount := 25 atRandom.
	1 to: itemCount do: [ :index |
		| priority todoItem |
		priority := 100 atRandom.
		todoItem := LoanexToy new
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
LoanexDatabase class >> buildUserDemo [
	| userModel |

	userModel := LoanexUser new
		username: 'demo';
		fullName: 'Demo User';
		passwordHash: (MDSLogin passwordHashFor: 'secret');
		yourself.

	userModel
		toDoItemsAdd: (LoanexToy new summary: 'foobar-1'; priority: 1; colorCode: (Color indexedColors at: 8); done: true; yourself);
		toDoItemsAdd: (LoanexToy new summary: 'foobar-2'; priority: 2; colorCode: (Color indexedColors at: 9); description: self loremText; yourself).

	VORepository current save: userModel.

	^ userModel

]

{ #category : #initalize }
LoanexDatabase class >> buildUserGuest [
	| userModel |

	userModel := LoanexUser new
		username: 'guest';
		fullName: 'Guest User';
		passwordHash: (MDSLogin passwordHashFor: 'secret');
		yourself.

	userModel
		toDoItemsAdd: (LoanexToy new summary: 'todo-1'; priority: 1; colorCode: (Color indexedColors at: 4); yourself);
		toDoItemsAdd: (LoanexToy new summary: 'todo-2'; priority: 2; colorCode: (Color indexedColors at: 5); description: self loremText; yourself);
		toDoItemsAdd: (LoanexToy new summary: 'todo-3'; priority: 3; colorCode: (Color indexedColors at: 6); done: true; yourself);
		toDoItemsAdd: (LoanexToy new summary: 'todo-4'; priority: 4; colorCode: (Color indexedColors at: 7); yourself).

	VORepository current save: userModel.

	^ userModel

]

{ #category : #'class initialization' }
LoanexDatabase class >> initialize [

	self repositorySetUpMemorySingleton
]

{ #category : #initalize }
LoanexDatabase class >> loremText [

	^ String loremIpsum truncateTo: 123
]

{ #category : #accessing }
LoanexDatabase class >> memory1 [
	^ Memory1
]

{ #category : #accessing }
LoanexDatabase class >> memory1: anObject [
	Memory1 := anObject
]

{ #category : #accessing }
LoanexDatabase class >> memory1Clear [

	Memory1 := nil
]

{ #category : #accessing }
LoanexDatabase class >> mongo1 [
	^ Mongo1
]

{ #category : #accessing }
LoanexDatabase class >> mongo1: anObject [
	Mongo1 := anObject
]

{ #category : #initalize }
LoanexDatabase class >> mongo1RecreateTestData [
	"
	self mongo1ResetConnection; mongo1RecreateTestData
	"

	self mongo1 ifNil: [
		"TODO: log an error"
		^ self ].

	self mongoRepositorySetUp: self mongo1
]

{ #category : #initalize }
LoanexDatabase class >> mongo1ResetConnection [

	Mongo1 := self mongoRepositoryBuild
]

{ #category : #accessing }
LoanexDatabase class >> mongoDatabase [

	^ DockerDeploy current mongoDatabaseDefault
]

{ #category : #accessing }
LoanexDatabase class >> mongoHost [

	^ DockerDeploy current mongoHostDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultHost ]
]

{ #category : #accessing }
LoanexDatabase class >> mongoPort [

	^ DockerDeploy current mongoPortDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultPort ]
]

{ #category : #initalize }
LoanexDatabase class >> mongoRepositoryBuild [
	| mongo username pwd |

	"
	To set up config values, run:
		DockerDeploy current runStartup
	"
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
LoanexDatabase class >> mongoRepositorySetUp: aMongoRepository [
	"
	self mongo1Clear.
	self mongoRepositorySetUp: self mongoRepositoryBuild.
	"

	aMongoRepository removeAll: LoanexUser.
	aMongoRepository removeAll: LoanexToy.

	1 to: 10 do: [ :index | self buildUser: 'mongo', index printString repository: aMongoRepository ]
]

{ #category : #initalize }
LoanexDatabase class >> repositorySetUpMemory1 [
	"
	self memory1Clear.
	self repositorySetUpMemory1.
	"

	self memory1: VOMemoryRepository new.

	1 to: 10 do: [ :index | self buildUser: 'a', index printString repository: self memory1 ]
]

{ #category : #initalize }
LoanexDatabase class >> repositorySetUpMemorySingleton [
	"
	self repositorySetUpMemorySingleton
	"
	| repository |

	VORepository current ifNotNil: [ :value | value reset ].
	repository := VOMemoryRepository new.
	repository enableSingleton.

	self buildUserDemo.
	self buildUserGuest.
	1 to: 5 do: [ :index |
		self buildUser: 'user', index printString ]
]

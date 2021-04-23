Class {
	#name : #TidbitExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Repository'
	],
	#category : #'Tidbit-Core'
}

{ #category : #initalize }
TidbitExampleDatabase class >> buildUser: aUsername [
	| userModel itemCount today |

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername capitalized, ' Test';
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
			colorCode: (Color indexedColors at: 256 atRandom);
			yourself.
		(priority \\ 3) isZero ifTrue: [ todoItem done: true ].
		(priority \\ 5) isZero ifTrue: [ todoItem description: self loremText ].
		todoItem save.
		userModel toDoItemsAdd: todoItem ].

	VORepository current save: userModel.

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

	self repositorySetUpMemory
]

{ #category : #initalize }
TidbitExampleDatabase class >> loremText [

	^ 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositoryClear [
	"
	self repositoryClear
	"

	VORepository current ifNotNil: [ :value | value reset ].
	VORepository setRepository: nil.

]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMemory [
	"
	self repositorySetUpMemory
	"
	| repository |

	self repositoryClear.
	repository := VOMemoryRepository new.
	repository enableSingleton.

	self buildUserDemo.
	self buildUserGuest.
	1 to: 10 do: [ :index |
		self buildUser: 'user', index printString ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMongo [
	"
	self repositorySetUpMongo
	"
	| repository |

	self repositoryClear.
	repository := VOMongoRepository database: 'Tidbit'.
	repository enableSingleton.

	self buildUserDemo.
	self buildUserGuest.
	1 to: 12 do: [ :index |
		self buildUser: 'mongo', index printString ]
]

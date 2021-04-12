Class {
	#name : #TBExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Repository'
	],
	#category : #'Tidbit-Core'
}

{ #category : #initalize }
TBExampleDatabase class >> buildTestDatabase [
	"
	self repositoryClear.
	self buildTestDatabase.
	"
	| userModel |

	userModel := TBUser new
		userId: 'testuser';
		firstName: 'Test';
		lastName: 'User';
		yourself.

	userModel toDoItems
		addAll: {
			TBToDoItem new summary: 'todo-1'; priority: 1; colorCode: (Color indexedColors at: 4); yourself.
			TBToDoItem new summary: 'todo-2'; priority: 2; colorCode: (Color indexedColors at: 5); description: self loremText; yourself.
			TBToDoItem new summary: 'todo-3'; priority: 3; colorCode: (Color indexedColors at: 6); yourself.
			TBToDoItem new summary: 'todo-4'; priority: 4; colorCode: (Color indexedColors at: 7); yourself.
			}.

	self repository save: userModel.

	^userModel

]

{ #category : #initalize }
TBExampleDatabase class >> initialize [
	self repositoryClear.
	Smalltalk addToShutDownList: self
]

{ #category : #initalize }
TBExampleDatabase class >> loremText [

	^ 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
]

{ #category : #initalize }
TBExampleDatabase class >> repository [

	Repository ifNil: [Repository := VOMemoryRepository new].
	^Repository

]

{ #category : #initalize }
TBExampleDatabase class >> repositoryClear [
	"
	self repositoryClear
	"

	Repository ifNotNil: [
		"Repository database close."
		Repository := nil ]

]

{ #category : #initalize }
TBExampleDatabase class >> repositoryName [

	^'TidbitExample'

]

{ #category : #initalize }
TBExampleDatabase class >> shutDown: quitting [
	
	"self repositoryClear."

]

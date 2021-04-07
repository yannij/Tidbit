Class {
	#name : #TBExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Repository'
	],
	#category : 'Tidbit-Core'
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
			TBToDoItem new description: 'todo-1'; priority: 1; yourself.
			TBToDoItem new description: 'todo-2'; priority: 2; yourself.
			TBToDoItem new description: 'todo-3'; priority: 3; yourself.
			TBToDoItem new description: 'todo-4'; priority: 4; yourself.
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

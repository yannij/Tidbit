Class {
	#name : #TBToDoMdlApplication,
	#superclass : #MDLApplication,
	#instVars : [
		'view'
	],
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #'class initialization' }
TBToDoMdlApplication class >> applicationPath [

	^'tidbit/todo-mdl'

]

{ #category : #'class initialization' }
TBToDoMdlApplication class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self registerToDevelopment: self applicationPath

]

{ #category : #actions }
TBToDoMdlApplication >> addToRecent: anObject [
]

{ #category : #accessing }
TBToDoMdlApplication >> browserTabTitle [

	^self headerTitle

]

{ #category : #actions }
TBToDoMdlApplication >> favCurrentObject [
]

{ #category : #initalize }
TBToDoMdlApplication >> getSessionUser [

	^self session properties at: #user ifAbsent: [ nil ]

]

{ #category : #accessing }
TBToDoMdlApplication >> headerTitle [

	^'Tidbit-ToDo'
]

{ #category : #initalize }
TBToDoMdlApplication >> initialize [

	super initialize.

	"self primaryColor: user primaryColor secondaryColor: user secondaryColor."
	self primaryColor: MDLColor randomColorAndTint secondaryColor: MDLColor randomColorAndTint.

	self setSessionUser: self retrieveTestModel.
	self setViewOn: self getSessionUser.

]

{ #category : #actions }
TBToDoMdlApplication >> removeFromRecentlyViewed: anObject [
]

{ #category : #rendering }
TBToDoMdlApplication >> renderContentOn: html [

	"html text: 'hello'."
	html render: (TBLayoutStructure withConfiguration: {'sideNav' -> true} asDictionary).

]

{ #category : #initalize }
TBToDoMdlApplication >> retrieveTestModel [

	^(TBExampleDatabase repository selectAll: TBUser) anyOne
]

{ #category : #initalize }
TBToDoMdlApplication >> saveObject: anObject [

	TBExampleDatabase repository save: anObject
]

{ #category : #initalize }
TBToDoMdlApplication >> setSessionUser: aUser [

	self session properties at: #user put: aUser.

]

{ #category : #actions }
TBToDoMdlApplication >> setViewOn: aModel [
	| newView |

	aModel isNil
		ifTrue: [ ^self ].

	newView := aModel asComponent
					"addValidatedForm;
					addMessage: 'hello';"
					yourself.

	self view: newView.

]

{ #category : #actions }
TBToDoMdlApplication >> switchToFavs [

	"self setViewOn: 'Favs'"
]

{ #category : #actions }
TBToDoMdlApplication >> switchToHome [

	"self setViewOn: 'Recent'"
]

{ #category : #actions }
TBToDoMdlApplication >> switchToRecent [

	"self setViewOn: 'Recent'"
]

{ #category : #rendering }
TBToDoMdlApplication >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot title: self browserTabTitle.

]

{ #category : #accessing }
TBToDoMdlApplication >> view [
	^ view
]

{ #category : #accessing }
TBToDoMdlApplication >> view: anObject [
	view := anObject
]

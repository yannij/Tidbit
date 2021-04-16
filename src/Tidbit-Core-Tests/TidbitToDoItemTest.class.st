Class {
	#name : #TidbitToDoItemTest,
	#superclass : #TestCase,
	#instVars : [
		'repository'
	],
	#category : #'Tidbit-Core-Tests'
}

{ #category : #accessing }
TidbitToDoItemTest >> repository [
	^ repository
]

{ #category : #accessing }
TidbitToDoItemTest >> repository: anObject [
	repository := anObject
]

{ #category : #running }
TidbitToDoItemTest >> setUp [

	super setUp
	"| env tx dbi |

	repository := VOLightningMDBRepository on: 'TidbitTest'.
	env := self repository database environment.
	
	tx := env beginTransaction.
	dbi := tx openDatabase: nil.
	tx empty: dbi.
	tx commit."
]

{ #category : #tests }
TidbitToDoItemTest >> testToDoItem [
	| item |

	item := TidbitToDoItem new
		description: 'abcd';
		yourself.

	self repository save: item.

]

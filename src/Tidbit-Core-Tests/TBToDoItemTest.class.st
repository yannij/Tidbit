Class {
	#name : #TBToDoItemTest,
	#superclass : #TestCase,
	#instVars : [
		'repository'
	],
	#category : 'Tidbit-Core-Tests'
}

{ #category : #accessing }
TBToDoItemTest >> repository [
	^ repository
]

{ #category : #accessing }
TBToDoItemTest >> repository: anObject [
	repository := anObject
]

{ #category : #running }
TBToDoItemTest >> setUp [
	| env tx dbi |

	repository := VOLightningMDBRepository on: 'TidbitTest'.
	env := self repository database environment.
	
	tx := env beginTransaction.
	dbi := tx openDatabase: nil.
	tx empty: dbi.
	tx commit.

]

{ #category : #tests }
TBToDoItemTest >> testToDoItem [
	| item |

	item := TBToDoItem new
		description: 'abcd';
		yourself.

	self repository save: item.

]

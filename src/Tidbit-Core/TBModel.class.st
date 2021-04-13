"
Abstract superclass of all Tidbit models, which are persisted using LMDB.

Notes:
https://github.com/LMDB
http://macappstore.org/lmdb/
"
Class {
	#name : #TBModel,
	#superclass : #MCWModel,
	#classVars : [
		'DescriptionContainerClass'
	],
	#category : #'Tidbit-Core'
}

{ #category : #accessing }
TBModel class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDLPriorityContainer.
	"

	DescriptionContainerClass ifNil: [ DescriptionContainerClass := MCWPriorityContainer ].
	^ DescriptionContainerClass

]

{ #category : #accessing }
TBModel class >> descriptionContainerClass: anObject [
	DescriptionContainerClass := anObject
]

{ #category : #printing }
TBModel >> chipIconName [

	^ #toys
]

{ #category : #printing }
TBModel >> dataBadgeValue [

	^ ''

]

{ #category : #printing }
TBModel >> hasDataBadge [

	^ false

]

{ #category : #printing }
TBModel >> mdDisplaySecondaryString [

	^ '<Model:', self hash printString, '>'
]

{ #category : #printing }
TBModel >> mdPrimaryString [

	^ self printString
]

{ #category : #printing }
TBModel >> mdlDisplayId [

	^ self printString
]

{ #category : #printing }
TBModel >> mdlDisplayString [

	^ self printString
]

{ #category : #printing }
TBModel >> mdlDisplaySummaryString [

	^ self mdlDisplayString truncateWithElipsisTo: 65
]

{ #category : #accessing }
TBModel >> mementoClass [

	^ MAStraightMemento
]

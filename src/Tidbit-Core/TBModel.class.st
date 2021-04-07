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
	#category : 'Tidbit-Core'
}

{ #category : #accessing }
TBModel class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDLPriorityContainer.
	"

	DescriptionContainerClass isNil
		ifTrue: [DescriptionContainerClass := MCWPriorityContainer].
	^DescriptionContainerClass

]

{ #category : #accessing }
TBModel class >> descriptionContainerClass: anObject [
	DescriptionContainerClass := anObject
]

{ #category : #displaying }
TBModel >> chipIconName [

	^#toys
]

{ #category : #displaying }
TBModel >> dataBadgeValue [

	^ ''

]

{ #category : #displaying }
TBModel >> hasDataBadge [

	^ false

]

{ #category : #printing }
TBModel >> mdDisplaySecondaryString [

	^'<', self hash printString, '>'
]

{ #category : #printing }
TBModel >> mdPrimaryString [

	^self printString
]

{ #category : #displaying }
TBModel >> mdlDisplayId [

	^self printString
]

{ #category : #displaying }
TBModel >> mdlDisplayString [

	^self printString
]

{ #category : #displaying }
TBModel >> mdlDisplaySummaryString [

	^ self mdlDisplayString truncateWithElipsisTo: 65
]

{ #category : #accessing }
TBModel >> mementoClass [

	^ MAStraightMemento
]

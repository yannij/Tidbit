Class {
	#name : #TidbitRootObject,
	#superclass : #MCWModel,
	#classInstVars : [
		'DescriptionContainerClass'
	],
	#category : #'Tidbit-Core'
}

{ #category : #accessing }
TidbitRootObject class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDLPriorityContainer.
	"

	DescriptionContainerClass ifNil: [ DescriptionContainerClass := MCWPriorityContainer ].
	^ DescriptionContainerClass

]

{ #category : #accessing }
TidbitRootObject class >> descriptionContainerClass: anObject [
	DescriptionContainerClass := anObject
]

{ #category : #printing }
TidbitRootObject >> chipIconName [

	^ #toys
]

{ #category : #printing }
TidbitRootObject >> dataBadgeValue [

	^ ''

]

{ #category : #printing }
TidbitRootObject >> hasDataBadge [

	^ false

]

{ #category : #printing }
TidbitRootObject >> mdDisplaySecondaryString [

	^ '<Model:', self hash printString, '>'
]

{ #category : #printing }
TidbitRootObject >> mdPrimaryString [

	^ self printString
]

{ #category : #printing }
TidbitRootObject >> mdlDisplayId [

	^ self printString
]

{ #category : #printing }
TidbitRootObject >> mdlDisplayString [

	^ self printString
]

{ #category : #printing }
TidbitRootObject >> mdlDisplaySummaryString [

	^ self mdlDisplayString truncateWithElipsisTo: 65
]

{ #category : #accessing }
TidbitRootObject >> mementoClass [

	^ MAStraightMemento
]

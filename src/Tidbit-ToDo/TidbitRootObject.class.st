Class {
	#name : #TidbitRootObject,
	#superclass : #MDMModel,
	#classInstVars : [
		'DescriptionContainerClass'
	],
	#category : #'Tidbit-ToDo-Model'
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
TidbitRootObject >> mdPrimaryString [

	^ self printString
]

{ #category : #printing }
TidbitRootObject >> mdSecondaryString [

	^ '<Model:', self hash printString, '>'
]

{ #category : #accessing }
TidbitRootObject >> mementoClass [

	^ MAStraightMemento
]

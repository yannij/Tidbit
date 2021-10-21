Class {
	#name : #LoanexRootObject,
	#superclass : #MDMModel,
	#classInstVars : [
		'DescriptionContainerClass'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #accessing }
LoanexRootObject class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDLPriorityContainer.
	"

	DescriptionContainerClass ifNil: [ DescriptionContainerClass := MCWPriorityContainer ].
	^ DescriptionContainerClass

]

{ #category : #accessing }
LoanexRootObject class >> descriptionContainerClass: anObject [
	DescriptionContainerClass := anObject
]

{ #category : #printing }
LoanexRootObject >> chipIconName [

	^ #toys
]

{ #category : #printing }
LoanexRootObject >> dataBadgeValue [

	^ ''

]

{ #category : #printing }
LoanexRootObject >> hasDataBadge [

	^ false

]

{ #category : #printing }
LoanexRootObject >> mdPrimaryString [

	^ self printString
]

{ #category : #printing }
LoanexRootObject >> mdSecondaryString [

	^ '<Model:', self hash printString, '>'
]

{ #category : #accessing }
LoanexRootObject >> mementoClass [

	^ MAStraightMemento
]

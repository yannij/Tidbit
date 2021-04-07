Class {
	#name : #TBRootObject,
	#superclass : #TBModel,
	#category : 'Tidbit-Core'
}

{ #category : #printing }
TBRootObject >> mdDisplayString [

	^self mdPrimaryString
]

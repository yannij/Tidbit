Class {
	#name : #VOLightningMDBFuture,
	#superclass : #VOJSONFuture,
	#instVars : [
		'repository'
	],
	#category : 'Voyage-LightningMDB'
}

{ #category : #'as yet unclassified' }
VOLightningMDBFuture class >> realObject: anObject repository: aRepository [ 
	^ (self realObject: anObject)
		repository: aRepository;
		yourself 
		
]

{ #category : #accessing }
VOLightningMDBFuture >> futureId [

	^VOLightningMDBFutureID for: self

]

{ #category : #accessing }
VOLightningMDBFuture >> repository [
	^ repository
]

{ #category : #accessing }
VOLightningMDBFuture >> repository: anObject [
	repository := anObject
]

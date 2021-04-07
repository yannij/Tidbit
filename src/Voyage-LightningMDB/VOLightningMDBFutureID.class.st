Class {
	#name : #VOLightningMDBFutureID,
	#superclass : #VOJSONFuture,
	#instVars : [
		'future'
	],
	#category : 'Voyage-LightningMDB'
}

{ #category : #'instance creation' }
VOLightningMDBFutureID class >> for: aFuture [
	^ self new future: aFuture
]

{ #category : #accessing }
VOLightningMDBFutureID >> future [
	^ future
]

{ #category : #accessing }
VOLightningMDBFutureID >> future: anObject [
	future := anObject
]

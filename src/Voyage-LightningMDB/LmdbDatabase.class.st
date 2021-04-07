Class {
	#name : #LmdbDatabase,
	#superclass : #Object,
	#instVars : [
		'environment',
		'database',
		'transaction'
	],
	#category : 'Voyage-LightningMDB'
}

{ #category : #opening }
LmdbDatabase class >> open: filePath [

	^self new open: filePath
]

{ #category : #transactions }
LmdbDatabase >> beginTransaction [

	[
		self transaction: self environment beginTransaction.
		self database: (self transaction openDatabase: nil "Use default database").
		^true]
			on: Error
			do: [^false]

]

{ #category : #closing }
LmdbDatabase >> close [

	self isOpen ifFalse: [ ^self ].

	self environment close.
	self environment: nil.

]

{ #category : #accessing }
LmdbDatabase >> collectionName: aString [
	^ LmdbCollection database: self name: aString
]

{ #category : #transactions }
LmdbDatabase >> commitTransaction [

	[
		self transaction commit.
		^true]
			on: Error
			do: [:ex | ex inspect. ^false]

]

{ #category : #opening }
LmdbDatabase >> createEnvironmentWith: aNameString [

	^MDBEnvironment create
		setMaxdbs: 12;
		setMapsize: 100 * 1024 * 4096; 					"400MB"
		open: (self path: aNameString) flags: 0;
		yourself
]

{ #category : #accessing }
LmdbDatabase >> database [
	^ database
]

{ #category : #accessing }
LmdbDatabase >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LmdbDatabase >> environment [
	^ environment
]

{ #category : #accessing }
LmdbDatabase >> environment: anObject [
	environment := anObject
]

{ #category : #testing }
LmdbDatabase >> isOpen [

	^self environment notNil

]

{ #category : #opening }
LmdbDatabase >> open: filePath [

	self isOpen ifTrue: [ ^self ].

	self environment: (self createEnvironmentWith: filePath).

]

{ #category : #opening }
LmdbDatabase >> path: aNameString [

	| ref |

	ref := (FileSystem disk referenceTo: aNameString) asAbsolute.
	ref isDirectory
		ifFalse: [ ref createDirectory ].
		
	^ref pathString
]

{ #category : #transactions }
LmdbDatabase >> rollbackTransaction [

	[
		self transaction abort.
		^true]
			on: Error
			do: [^false]

]

{ #category : #transactions }
LmdbDatabase >> transact: aBlock [

	self beginTransaction.
	aBlock ensure: [ 
		(self commitTransaction) ifFalse: [ 
			self rollbackTransaction. 
			PqError signal: 'Could not commit.' ] ].
]

{ #category : #accessing }
LmdbDatabase >> transaction [
	^ transaction
]

{ #category : #accessing }
LmdbDatabase >> transaction: anObject [
	transaction := anObject
]

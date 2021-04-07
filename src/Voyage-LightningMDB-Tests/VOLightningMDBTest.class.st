Class {
	#name : #VOLightningMDBTest,
	#superclass : #VORepositoryTest,
	#instVars : [
		'repository'
	],
	#category : 'Voyage-LightningMDB-Tests'
}

{ #category : #accessing }
VOLightningMDBTest >> repository [ 
	^ repository
]

{ #category : #running }
VOLightningMDBTest >> setUp [
	| env tx dbi |

	repository := VOLightningMDBRepository on: 'FOO1'.

	"env := MDBEnvironment create."
	env := self repository database environment.
	"env open: self path."
	
	tx := env beginTransaction.
	dbi := tx openDatabase: nil.
	tx empty: dbi.
	tx commit.

]

{ #category : #tests }
VOLightningMDBTest >> testCount [
	super testCount
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testCountWhere [
	super testCountWhere
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testIsLazy [
	super testIsLazy

]

{ #category : #tests }
VOLightningMDBTest >> testIsLazyOnToManyRelations [
	super testIsLazyOnToManyRelations
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testIsNew [
	"super testIsNew"
	self skip
]

{ #category : #tests }
VOLightningMDBTest >> testSave [
	super testSave
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testSaveCircular [
	super testSaveCircular
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testSaveSimple [
	| pilot pilots |

	pilot := VOTestPilot new
		name: 'Esteban';
		"pet: (VOTestDog new name: 'Doggie');"
		yourself.
	self repository save: pilot.
	self waitForWriteOperation.

	pilots := self repository selectAll: VOTestPilot.
	self assert: pilots size equals: 1.
	self assert: pilots anyOne name equals: 'Esteban'.

]

{ #category : #tests }
VOLightningMDBTest >> testSaveWithClasses [
	super testSaveWithClasses
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testSaveWithSubclasses [
	super testSaveWithSubclasses
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testSaveWithSubclassesAndRelations [
	super testSaveWithSubclassesAndRelations
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testSelectManyWithAllKeyword [
	self skip
]

{ #category : #tests }
VOLightningMDBTest >> testSelectManyWithLimitAndOffset [
	| firstBatch secondBatch thirdBatch |
	self repository
		save: (VOTestPilot new name: 'Esteban');
		save: (VOTestPilot new name: 'Mariano');
		save: (VOTestPilot new name: 'Stef');
		save: (VOTestPilot new name: 'Camillo');
		save: (VOTestPilot new name: 'Igor');
		save: (VOTestPilot new name: 'Markus');
		yourself.
	self repository flushCache.
	
	firstBatch := self repository selectMany: VOTestPilot where: [ :each | true ] limit: 2. 
	secondBatch := self repository selectMany: VOTestPilot where: [ :each | true ] limit: 2 offset: 2.
	thirdBatch := self repository selectMany: VOTestPilot where: [ :each | true ] limit: 2 offset: 1.
	self assert: firstBatch size equals: 2.
	self assert: secondBatch size equals: 2.
	self assert: (firstBatch intersection: secondBatch) isEmpty.
	self assert: (firstBatch intersection: thirdBatch) size equals: 1.
]

{ #category : #tests }
VOLightningMDBTest >> testSelectOneWithSubclass [
	super testSelectOneWithSubclass
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testUpdate [
	super testUpdate
	"self skip"
]

{ #category : #tests }
VOLightningMDBTest >> testUpdateSimple [
	| pilot pilots id |
	
	pilot := VOTestPilot new
		name: 'Esteban';
		"pet: (VOTestDog new name: 'Doggie')."
		yourself.
	self repository save: pilot.
	self waitForWriteOperation.
	
	id := self repository idOf: pilot.
	
	pilot name: 'Another Pilot'.
	self repository save: pilot.
	self waitForWriteOperation.
	
	pilots := self repository selectAll: VOTestPilot.
	self assert: pilots size equals: 1.
	self assert: pilots anyOne equals: pilot.
	self assert: (self repository idOf: pilot) equals: id.
]

{ #category : #tests }
VOLightningMDBTest >> testVersionAt [
	| pilot id aVersion anotherVersion |
	
	pilot := VOTestPilot new name: 'Esteban'.
	self repository save: pilot.
	
	id := self repository idOf: pilot.
	aVersion := (self repository cacheAt: VOTestPilot) versionAt: id.
	
	pilot name: 'Another Pilot'.
	self repository save: pilot.

	anotherVersion := (self repository cacheAt: VOTestPilot) versionAt: id.
	
	self deny: aVersion = anotherVersion.
]

{ #category : #tests }
VOLightningMDBTest >> testVersionGenerator [
	super testVersionGenerator
	"self skip"
]

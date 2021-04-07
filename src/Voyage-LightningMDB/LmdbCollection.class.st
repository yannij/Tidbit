Class {
	#name : #LmdbCollection,
	#superclass : #Object,
	#instVars : [
		'name',
		'database'
	],
	#category : 'Voyage-LightningMDB'
}

{ #category : #'instance creation' }
LmdbCollection class >> database: aDatabase name: aString [
	^ self basicNew 
		initializeDatabase: aDatabase name: aString;
		yourself
]

{ #category : #'instance creation' }
LmdbCollection class >> new [
	self error: 'Use #database:name:'
]

{ #category : #adding }
LmdbCollection >> add: jsonDictionary [
	"Adds a JSON dictionary to collection. 
	 Answers the id of the record inserted"

	| newId dataValue |
	newId := UUIDGenerator next printString.
	jsonDictionary
		at: VOLightningMDBJSONSerializer fieldId put: newId;
		yourself.
	dataValue := self jsonStringFrom: jsonDictionary.
	Transcript cr; show: 'K: ', newId, ' V: ', dataValue.
	(self database transaction
		put: "self name," newId
		data: (self jsonStringFrom: jsonDictionary)
		database: self database database)
			"commit".
	^newId
]

{ #category : #accessing }
LmdbCollection >> at: anId [
	"retrieves a documents with id or nil if not found"

	^(self select: [:each | (each at: VOLightningMDBJSONSerializer fieldId) = anId ]) 
		ifNotEmpty: [ :result | result first ]
		ifEmpty: [ nil ]

]

{ #category : #accessing }
LmdbCollection >> at: anId put: jsonDictionary [
	"Replaces the contents of document id 'anId' with new contents"
	| dataValue |

	jsonDictionary
		at: VOLightningMDBJSONSerializer fieldId put: anId;
		yourself.
	dataValue := self jsonStringFrom: jsonDictionary.
	Transcript cr; show: 'K: ', anId, ' V: ', dataValue.
	(self database transaction
		put: anId
		data: dataValue
		database: self database database)

]

{ #category : #private }
LmdbCollection >> database [
	^ database
]

{ #category : #enumerating }
LmdbCollection >> detect: aBlock [
	"Answer first document that matches aBlock."

	^(self select: aBlock) 
		ifNotEmpty: [ :result | result first ]
		ifEmpty: [ nil ]
]

{ #category : #initialization }
LmdbCollection >> initializeDatabase: aDatabase name: aString [

	database := aDatabase.
	name := aString.
	self initialize
]

{ #category : #private }
LmdbCollection >> jsonStringFrom: anObject [
	| stream |

	stream := String new writeStream.

	(NeoJSONWriter on: stream)
		for: DateAndTime customDo: [ :mapping |
			mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
		for: Date customDo: [ :mapping |
			mapping encoder: [ :date | date yyyymmdd ] ];
		for: VOLightningMDBFutureID customDo: [ :mapping |
			mapping encoder: [ :futureID | futureID future repository idOf: futureID future realObject ] ];
		nextPut: anObject;
		yourself.

	^stream contents

]

{ #category : #accessing }
LmdbCollection >> name [
	^ name
]

{ #category : #accessing }
LmdbCollection >> removeAt: anId [
	"Removes the document with id 'anId'"
	| executor id |
	
	executor := self jx9Remove.
	executor reset.
	id := (anId jx9ValueOn: executor) name: 'id'.
	executor inject: id.
	executor execute.
	executor release: id.
	self validateResultFrom: executor
]

{ #category : #enumerating }
LmdbCollection >> select: aBlock [
	"Answer all documents that matches aBlock"

	^self selectAll select: aBlock
]

{ #category : #enumerating }
LmdbCollection >> selectAll [
	"Answer all documents in a collection"
	| cursor values assoc |

	values := OrderedCollection new.
	self database beginTransaction.
	cursor := self database transaction openCursor: self database database.
	[(assoc := cursor next) notNil] whileTrue: [
		| key data map |
		key := assoc key dataAsByteString.
		data := assoc value dataAsByteString.
		map := STON fromString: data.
		map at: VOLightningMDBJSONMaterializer fieldId put: key.
		values add: map ].
	self database transaction abort.
	^values asArray
]

{ #category : #accessing }
LmdbCollection >> size [
	"Answer the size of current collection (# of records)"
	| count |

	count := nil.
	self database beginTransaction.
	count := (self database transaction stat: self database database) entries.
	self database transaction abort.
	^count
]

{ #category : #accessing }
LmdbCollection >> sizeOf: aBlock [
	"Answer all documents that matches aBlock"

	^(self selectAll select: aBlock) size
]

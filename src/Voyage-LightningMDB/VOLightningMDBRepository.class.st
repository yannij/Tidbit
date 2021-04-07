Class {
	#name : #VOLightningMDBRepository,
	#superclass : #VORepository,
	#instVars : [
		'databaseReference',
		'database',
		'collections',
		'cacheByCollection',
		'versionGenerator',
		'ongoingTransaction'
	],
	#category : 'Voyage-LightningMDB'
}

{ #category : #defaults }
VOLightningMDBRepository class >> defaultVersionGenerator [
	^ VOVersionGenerator newDefault
]

{ #category : #'instance creation' }
VOLightningMDBRepository class >> on: aFileReferenceOrString [
	^ self basicNew 
		initializeOn: aFileReferenceOrString;
		yourself
]

{ #category : #accessing }
VOLightningMDBRepository class >> platformIdentifier [
	^ #lightningMDB
]

{ #category : #private }
VOLightningMDBRepository >> cacheAt: aClass [
	^ cacheByCollection
		at: aClass persistentClass 
		ifAbsentPut: [ VOCache new ]
]

{ #category : #'open/close' }
VOLightningMDBRepository >> close [
	database ifNil: [ ^ self ].
	database close.
	database := nil.
	collections := Dictionary new
]

{ #category : #private }
VOLightningMDBRepository >> collectionAt: aClass [
	^ collections 
		at: aClass persistentClass
		ifAbsentPut: [ self database collectionName: (self collectionNameFor: aClass) ]
]

{ #category : #private }
VOLightningMDBRepository >> collectionNameFor: aClass [
	^ (self descriptionBuilder for: aClass) collectionName
]

{ #category : #persistence }
VOLightningMDBRepository >> commit: aBlock [ 
	ongoingTransaction ifTrue: [ 
		aBlock value. 
		^ self ].

	[	ongoingTransaction := true. 
		self database transact: [ aBlock value ] ]
	ensure: [ 
		ongoingTransaction := false ]
]

{ #category : #persistence }
VOLightningMDBRepository >> count: aClass [
	"TODO: Find faster way"
	^(self selectAll: aClass) size
	"^ (self collectionAt: aClass) size "
]

{ #category : #persistence }
VOLightningMDBRepository >> count: aClass where: condition [
	^ (self collectionAt: aClass) sizeOf: condition
]

{ #category : #accessing }
VOLightningMDBRepository >> database [
	^ database
]

{ #category : #private }
VOLightningMDBRepository >> descriptionBuilder [
	^ descriptionBuilder ifNil: [ descriptionBuilder := VODescriptionBuilder repository: self ]
]

{ #category : #enumerating }
VOLightningMDBRepository >> dumpAll [
	"Answer all key/value pairs"
	"
	(VOLightningMDBRepository on: 'TidbitExample') dumpAll; close.
	"
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
	^values inspect
]

{ #category : #accessing }
VOLightningMDBRepository >> flushCache [
	cacheByCollection valuesDo: #flush
]

{ #category : #accessing }
VOLightningMDBRepository >> futureClass [
	^ VOLightningMDBFuture
]

{ #category : #'private persistence' }
VOLightningMDBRepository >> futureInsert: aFuture [
	| newId newVersion |
	newVersion := self versionGenerator newVersion.
	newId := (self collectionAt: aFuture realObject class) 
		add: (aFuture serialized
			at: VOLightningMDBJSONSerializer fieldVersion put: newVersion;
			yourself). 
	(self cacheAt: aFuture realObject class)
		cacheObject: aFuture realObject 
		id: newId
		version: newVersion
]

{ #category : #'private persistence' }
VOLightningMDBRepository >> futureInsertOrUpdate: aFuture id: idObject [
	idObject
		ifNotNil: [ self futureUpdate: aFuture ]
		ifNil: [ self futureInsert: aFuture ]
]

{ #category : #'private persistence' }
VOLightningMDBRepository >> futureUpdate: aFuture [
	| object objectClass newVersion id |
	
	object := aFuture realObject.
	objectClass := object class.

	id := self idOf: object.
	newVersion := self versionGenerator newVersion.
	(self collectionAt: objectClass) 
		at: id 
		put: (aFuture serialized
			at: VOLightningMDBJSONSerializer fieldVersion put: newVersion;
			yourself).
	(self cacheAt: objectClass)
		cacheObject: object 
		id: id 
		version: newVersion  
]

{ #category : #accessing }
VOLightningMDBRepository >> idOf: anObject [
	^ (self cacheAt: anObject class) 
		keyAtValue: anObject 
		ifAbsent: [ nil ]
]

{ #category : #initialization }
VOLightningMDBRepository >> initialize [
	super initialize.
	ongoingTransaction := false.
	collections := Dictionary new.
	cacheByCollection := Dictionary new.
	versionGenerator := self class defaultVersionGenerator
	
]

{ #category : #initialization }
VOLightningMDBRepository >> initializeOn: aFileReferenceOrString [
	self initialize.
	databaseReference := aFileReferenceOrString asFileReference.
	self open.
]

{ #category : #testing }
VOLightningMDBRepository >> isNew: anObject [ 
	^ (self idOf: anObject) isNil
]

{ #category : #testing }
VOLightningMDBRepository >> isOpen [
	^ database notNil and: [ database isOpen ]
]

{ #category : #accessing }
VOLightningMDBRepository >> lazyProxyClass [
	^ VOLightningMDBLazyProxy
]

{ #category : #private }
VOLightningMDBRepository >> materializeObject: jsonDictionary of: aClass [
	| materializer id object | 
	materializer := self newMaterializer. 
	id := jsonDictionary 
		at: VOLightningMDBJSONMaterializer fieldId
		ifAbsent: [ VOLightningMDBError signal: 'Trying to materialise an object without id.' ].
	object := (self cacheAt: aClass) at: id.
	object ifNil: [ object := (self retrieveClassOf: aClass json: jsonDictionary) basicNew ].
	materializer materialize: object fromJSON: jsonDictionary.
	(self cacheAt: aClass) 
		cacheObject: object 
		id: id 
		version: (jsonDictionary at: VOLightningMDBJSONSerializer fieldVersion).
	^ object
]

{ #category : #private }
VOLightningMDBRepository >> materializeSelection: rawSelected of: aClass [
	| selected |
	selected := rawSelected collect: [ :each | self materializeObject: each of: aClass ].
	^ aClass == aClass persistentClass 
		ifTrue: [ selected ]
		ifFalse: [ selected select: [ :each | each isKindOf: aClass ] ]
]

{ #category : #'private factory' }
VOLightningMDBRepository >> newMaterializer [
	^ VOLightningMDBJSONMaterializer repository: self
]

{ #category : #'private factory' }
VOLightningMDBRepository >> newSerializer [
	^ VOLightningMDBJSONSerializer repository: self
]

{ #category : #'open/close' }
VOLightningMDBRepository >> open [
	database ifNotNil: [ self close ].
	database := LmdbDatabase open: databaseReference path basename.

]

{ #category : #persistence }
VOLightningMDBRepository >> remove: anObject [ 
	| id |
	id := self idOf: anObject.
	id ifNil: [ NotFound signal: (anObject asString, ' not found.') ].
	self commit: [ 
		^ (self collectionAt: anObject class) remove: id ]
]

{ #category : #persistence }
VOLightningMDBRepository >> removeAll: aClass [ 
	self notYetImplemented
]

{ #category : #accessing }
VOLightningMDBRepository >> reset [
	self flushCache.
	self descriptionBuilder flush.
]

{ #category : #private }
VOLightningMDBRepository >> retrieveClassOf: aClass json: aDictionary [
	| retrievedClass |

	aDictionary 
		at: VOLightningMDBJSONSerializer fieldType
		ifPresent: [ :type | 
			retrievedClass := Smalltalk globals at: type asSymbol.
			(retrievedClass = aClass or: [ retrievedClass inheritsFrom: aClass persistentClass ])
				ifFalse: [ 
					VOLightningMDBError signal: ('Bad object requested ({1} does not inherits from {2})' 
						format: {
							retrievedClass name. 
							aClass name })] ].
			
	^retrievedClass ifNil: [ aClass ]
]

{ #category : #persistence }
VOLightningMDBRepository >> save: anObject [
	| futures |
	
	futures := self serialize: anObject.
	self commit: [ 
		"As a simple optimization, do not iterate twice if I have just one future (which means 
		 there are not relations)"
		futures size = 1 ifTrue: [ 
			^ self futureInsertOrUpdate: futures first id: (self idOf: futures first realObject) ].
		"Ok, they are references, and I do not know if they are cyclic... so I persist twice to 
		 be sure all references are correctly setted."
		2 timesRepeat: [ 
			futures reverseDo: [ :each | 
			 self futureInsertOrUpdate: each id: (self idOf: each realObject) ] ] ]. 
]

{ #category : #persistence }
VOLightningMDBRepository >> selectAll: aClass [ 
	| selectedValues |

	selectedValues := (self collectionAt: aClass) selectAll.

	^ self 
		materializeSelection: (
			selectedValues select: [:each | | type retrievedClass |
				type := each at: VOLightningMDBJSONMaterializer fieldType.
				retrievedClass := Smalltalk globals at: type asSymbol.
				retrievedClass = aClass or: [ retrievedClass inheritsFrom: aClass persistentClass ]])
		of: aClass
]

{ #category : #persistence }
VOLightningMDBRepository >> selectMany: aClass where: condition [
	^ self 
		materializeSelection: ((self collectionAt: aClass) select: condition)
		of: aClass
]

{ #category : #persistence }
VOLightningMDBRepository >> selectMany: aClass where: condition limit: aNumber [
	^ self 
		selectMany: aClass 
		where: condition 
		limit: aNumber
		offset: 0
]

{ #category : #persistence }
VOLightningMDBRepository >> selectMany: aClass where: condition limit: limit offset: offset [
	"unqlite does not seems to have a way to execute a query with offset and limit, so we 
	 simulate it for now. 
	 Offset is zero based."
	| selected size |
	
	selected := self selectMany: aClass where: condition.
	size := selected size.
	size < offset ifTrue: [ ^ #() ].
	
	^ selected copyFrom: offset + 1 to: ((offset + limit) min: size)
]

{ #category : #persistence }
VOLightningMDBRepository >> selectOne: aClass id: anId [
	"Special case, unqlite allows fast search by id... we use it specially in proxies"
	| rawSelected selected |
	rawSelected := (self collectionAt: aClass) at: anId.
	rawSelected ifNil: [ ^ nil ].
	selected := self materializeObject: rawSelected of: aClass.
	^ (selected isKindOf: aClass persistentClass) 
		ifTrue: [ selected ]
		ifFalse: [ nil ]	
]

{ #category : #persistence }
VOLightningMDBRepository >> selectOne: aClass where: condition [
	| rawSelected selected |
	rawSelected := (self collectionAt: aClass) detect: condition.
	rawSelected ifNil: [ ^ nil ].
	selected := self materializeObject: rawSelected of: aClass.
	^ (selected isKindOf: aClass persistentClass) 
		ifTrue: [ selected ]
		ifFalse: [ nil ]
]

{ #category : #private }
VOLightningMDBRepository >> serialize: anObject [ 
	^ self newSerializer serialize: anObject
]

{ #category : #accessing }
VOLightningMDBRepository >> versionAt: anId [
	"this is not good"
	^ nil
]

{ #category : #accessing }
VOLightningMDBRepository >> versionGenerator [
	^ versionGenerator
]

{ #category : #accessing }
VOLightningMDBRepository >> versionGenerator: aVersionGenerator [
	versionGenerator := aVersionGenerator
]

{ #category : #accessing }
VOLightningMDBRepository >> versionOf: anObject [ 
	| cache |
	cache := self cacheAt: anObject class.
	^ cache versionAt: (cache keyAtValue: anObject)
		
]

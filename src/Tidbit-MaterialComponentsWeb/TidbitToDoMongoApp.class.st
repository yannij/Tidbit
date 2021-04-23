Class {
	#name : #TidbitToDoMongoApp,
	#superclass : #TidbitToDoApp,
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #'class initialization' }
TidbitToDoMongoApp class >> applicationPath [

	^ 'tidbit/todo-mongo'
]

{ #category : #'class initialization' }
TidbitToDoMongoApp class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self mcwRegisterDeployment: self applicationPath
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> mongoHost [

	^ OSEnvironment current at: 'MONGO_HOST' ifAbsentPut: [ VOMongoRepository defaultHost ]
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> mongoPort [

	^ OSEnvironment current at: 'MONGO_PORT' ifAbsentPut: [ VOMongoRepository defaultPort ]
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repository [

	^ VORepository current
		ifNotNil: [ :value | value ]
		ifNil: [
			(VOMongoRepository host: self mongoHost port: self mongoPort database: 'Tidbit')
				enableSingleton;
				yourself ]
]

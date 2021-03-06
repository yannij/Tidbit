"
I am a specialized subclass that stores data in MongoDB instead.

Docker instructions:

docker network create tidbit-app
docker run -it --network tidbit-app --network-alias mongo -v /Users/yanni/mongodata:/data/db -p 27017:27017 --name mongo -d mongo
docker run --network tidbit-app --network-alias tidbit1 -e MONGO_HOST=mongo -d -p 80:8080 tidbit

# Initialize the database
docker exec -it mongo bash
pharo Pharo.image eval ""TidbitExampleDatabase repositorySetUpMongo1Host: 'mongo' port: VOMongoRepository defaultPort""
"
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

{ #category : #accessing }
TidbitToDoMongoApp >> applicationTitle [

	^ 'Tidbit ToDo/Mongo'
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repository [

	^ TidbitExampleDatabase mongo1
		ifNotNil: [ :value | value ]
		ifNil: [
			TidbitExampleDatabase repositorySetUpMongo1.
			TidbitExampleDatabase mongo1 ]
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repositoryClear [

	TidbitExampleDatabase mongo1Clear
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repositoryReset [

	TidbitExampleDatabase repositorySetUpMongo1
]

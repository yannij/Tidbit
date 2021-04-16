Class {
	#name : #TidbitUser,
	#superclass : #TidbitRootObject,
	#instVars : [
		'userId',
		'dateCreated',
		'passwordHash',
		'firstName',
		'lastName',
		'userSettings',
		'toDoItems'
	],
	#category : #'Tidbit-Core'
}

{ #category : #voyage }
TidbitUser class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
TidbitUser >> dateCreated [
	^ dateCreated
]

{ #category : #accessing }
TidbitUser >> dateCreated: anObject [
	dateCreated := anObject
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionDateCreated [
	<magritteDescription>

	^ MADateAndTimeDescription new
		"accessor: #dateCreated;"
		accessor: (MAPluggableAccessor 
			read: [ :item | item dateCreated ]
			write: [ :item :value | value ifNotNil: [ :arg | item dateCreated: value ] ]);
		default: DateAndTime now printString;
		label: 'Date Created';
		cssClass: 'mcw-textfield';
		priority: 17;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionFirstName [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #firstName;
		default: '';
		label: 'First Name';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionLastName [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #lastName;
		default: '';
		label: 'Last Name';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionPasswordHash [
	<magritteDescription>

	^ MAPasswordDescription new
		accessor: #passwordHash;
		default: '';
		label: 'Password';
		cssClass: 'mcw-textfield';
		priority: 15;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionToDoItems [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #toDoItems;
		classes: {TidbitToDoItem};
		default: OrderedCollection new;
		label: 'ToDo Items';
		cssClass: 'mcw-textfield';
		priority: 40;
		"beOrdered;"
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionUserId [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #userId;
		default: '';
		label: 'User ID';
		cssClass: 'mcw-textfield';
		priority: 10;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionUserSettings [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #userSettings;
		label: 'User Settings';
		classes: {TidbitUserSettings};
		cssClass: 'mcw-textfield';
		priority: 35;
		beRequired;
		yourself
]

{ #category : #accessing }
TidbitUser >> firstName [
	^ firstName
]

{ #category : #accessing }
TidbitUser >> firstName: anObject [
	firstName := anObject
]

{ #category : #initialization }
TidbitUser >> initialize [

	super initialize.

	self userId: String new.
	self passwordHash: String new.
	self dateCreated: DateAndTime now.
	self firstName: String new.
	self lastName: String new.

	self userSettings: TidbitUserSettings new.
	self toDoItems: OrderedCollection new.

]

{ #category : #accessing }
TidbitUser >> lastName [
	^ lastName
]

{ #category : #accessing }
TidbitUser >> lastName: anObject [
	lastName := anObject
]

{ #category : #printing }
TidbitUser >> mdPrimaryString [

	^ self userId
]

{ #category : #accessing }
TidbitUser >> passwordHash [
	^ passwordHash
]

{ #category : #accessing }
TidbitUser >> passwordHash: anObject [
	passwordHash := anObject
]

{ #category : #accessing }
TidbitUser >> toDoItems [
	^ toDoItems
]

{ #category : #accessing }
TidbitUser >> toDoItems: anObject [
	toDoItems := anObject
]

{ #category : #accessing }
TidbitUser >> toDoItemsAdd: anItem [

	self toDoItems add: anItem
]

{ #category : #accessing }
TidbitUser >> userId [
	^ userId
]

{ #category : #accessing }
TidbitUser >> userId: anObject [
	userId := anObject
]

{ #category : #accessing }
TidbitUser >> userSettings [
	^ userSettings
]

{ #category : #accessing }
TidbitUser >> userSettings: anObject [
	userSettings := anObject
]

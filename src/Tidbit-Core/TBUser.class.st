Class {
	#name : #TBUser,
	#superclass : #TBRootObject,
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
TBUser class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
TBUser >> dateCreated [
	^ dateCreated
]

{ #category : #accessing }
TBUser >> dateCreated: anObject [
	dateCreated := anObject
]

{ #category : #'accessing-magritte' }
TBUser >> descriptionDateCreated [
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
TBUser >> descriptionFirstName [
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
TBUser >> descriptionLastName [
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
TBUser >> descriptionPasswordHash [
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
TBUser >> descriptionToDoItems [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #toDoItems;
		classes: {TBToDoItem};
		default: OrderedCollection new;
		label: 'ToDo Items';
		cssClass: 'mcw-textfield';
		priority: 40;
		"beOrdered;"
		yourself
]

{ #category : #'accessing-magritte' }
TBUser >> descriptionUserId [
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
TBUser >> descriptionUserSettings [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #userSettings;
		label: 'User Settings';
		classes: {TBUserSettings};
		cssClass: 'mcw-textfield';
		priority: 35;
		beRequired;
		yourself
]

{ #category : #accessing }
TBUser >> firstName [
	^ firstName
]

{ #category : #accessing }
TBUser >> firstName: anObject [
	firstName := anObject
]

{ #category : #initialization }
TBUser >> initialize [

	super initialize.

	self userId: String new.
	self passwordHash: String new.
	self dateCreated: DateAndTime now.
	self firstName: String new.
	self lastName: String new.

	self userSettings: TBUserSettings new.
	self toDoItems: OrderedCollection new.

]

{ #category : #accessing }
TBUser >> lastName [
	^ lastName
]

{ #category : #accessing }
TBUser >> lastName: anObject [
	lastName := anObject
]

{ #category : #printing }
TBUser >> mdPrimaryString [

	^ self userId
]

{ #category : #accessing }
TBUser >> passwordHash [
	^ passwordHash
]

{ #category : #accessing }
TBUser >> passwordHash: anObject [
	passwordHash := anObject
]

{ #category : #accessing }
TBUser >> toDoItems [
	^ toDoItems
]

{ #category : #accessing }
TBUser >> toDoItems: anObject [
	toDoItems := anObject
]

{ #category : #accessing }
TBUser >> toDoItemsAdd: anItem [

	self toDoItems add: anItem
]

{ #category : #accessing }
TBUser >> userId [
	^ userId
]

{ #category : #accessing }
TBUser >> userId: anObject [
	userId := anObject
]

{ #category : #accessing }
TBUser >> userSettings [
	^ userSettings
]

{ #category : #accessing }
TBUser >> userSettings: anObject [
	userSettings := anObject
]

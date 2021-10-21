Class {
	#name : #LoanexUser,
	#superclass : #LoanexRootObject,
	#instVars : [
		'dateCreated',
		'username',
		'passwordHash',
		'fullName',
		'email',
		'userSettings',
		'toDoItems',
		'website'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #voyage }
LoanexUser class >> descriptionToDoItems [
	<voyageDescription>

	^ VOToManyDescription new
		attributeName: 'toDoItems';
		accessor: #toDoItems;
		beLazy;
		yourself
]

{ #category : #voyage }
LoanexUser class >> descriptionUserSettings [
	"<voyageDescription>"

	^ VOToOneDescription new
		attributeName: 'userSettings';
		accessor: #userSettings;
		beLazy;
		yourself
]

{ #category : #voyage }
LoanexUser class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
LoanexUser >> dateCreated [
	^ dateCreated
]

{ #category : #accessing }
LoanexUser >> dateCreated: anObject [
	dateCreated := anObject
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionDateCreated [
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
LoanexUser >> descriptionEmail [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #email;
		default: '';
		label: 'Email';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionFullName [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #fullName;
		default: '';
		label: 'Full Name';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionPasswordHash [
	<magritteDescription>

	^ MAPasswordDescription new
		accessor: #passwordHash;
		default: '';
		label: 'Password';
		cssClass: 'mcw-textfield';
		priority: 15;
		beHidden;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionToDoItems [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #toDoItems;
		classes: (Array with: LoanexToy);
		default: OrderedCollection new;
		label: 'Toys';
		cssClass: 'mcw-textfield';
		priority: 45;
		"beOrdered;"
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionToDoItemsCount [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #toDoItemsCount;
		default: 0;
		label: 'ToDo Count';
		cssClass: 'mcw-textfield';
		priority: 40;
		beInteger;
		beReadonly;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionUserSettings [
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

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionUsername [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #username;
		default: '';
		label: 'Username';
		cssClass: 'mcw-textfield';
		priority: 10;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionWebSite [
	<magritteDescription>

	^ MAUrlDescription new
		accessor: #website;
		default: '';
		label: 'Website';
		cssClass: 'mcw-textfield';
		priority: 35;
		yourself
]

{ #category : #accessing }
LoanexUser >> email [
	^ email
]

{ #category : #accessing }
LoanexUser >> email: anObject [
	email := anObject
]

{ #category : #accessing }
LoanexUser >> fullName [
	^ fullName
]

{ #category : #accessing }
LoanexUser >> fullName: anObject [
	fullName := anObject
]

{ #category : #initialization }
LoanexUser >> initialize [

	super initialize.

	self username: String new.
	self passwordHash: String new.
	self dateCreated: DateAndTime now.
	self fullName: String new.
	self email: String new.
	self website: String new.

	self userSettings: (TidbitUserSettings on: self).
	self toDoItems: OrderedCollection new.

]

{ #category : #printing }
LoanexUser >> mdPrimaryString [

	^ self username
]

{ #category : #accessing }
LoanexUser >> passwordHash [
	^ passwordHash
]

{ #category : #accessing }
LoanexUser >> passwordHash: anObject [
	passwordHash := anObject
]

{ #category : #accessing }
LoanexUser >> toDoItems [
	^ toDoItems
]

{ #category : #accessing }
LoanexUser >> toDoItems: anObject [
	toDoItems := anObject
]

{ #category : #accessing }
LoanexUser >> toDoItemsAdd: anItem [

	self toDoItems add: anItem
]

{ #category : #accessing }
LoanexUser >> toDoItemsCount [

	^ toDoItems size
]

{ #category : #accessing }
LoanexUser >> userSettings [
	^ userSettings
]

{ #category : #accessing }
LoanexUser >> userSettings: anObject [
	userSettings := anObject
]

{ #category : #accessing }
LoanexUser >> username [
	^ username
]

{ #category : #accessing }
LoanexUser >> username: anObject [
	username := anObject
]

{ #category : #accessing }
LoanexUser >> website [
	^ website
]

{ #category : #accessing }
LoanexUser >> website: anObject [
	website := anObject
]

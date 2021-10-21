Class {
	#name : #LoanexToy,
	#superclass : #LoanexRootObject,
	#instVars : [
		'summary',
		'description',
		'done',
		'completeByDate',
		'completeByTime',
		'priority',
		'colorCode',
		'estimatedDuration',
		'importance',
		'calendars'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #voyage }
LoanexToy class >> descriptionContainer [
	<voyageContainer>

	^ VOContainer new
		collectionName: 'TidbitToDoItem'
		yourself
]

{ #category : #accessing }
LoanexToy class >> importanceValueHigh [

	^ 'High'
]

{ #category : #accessing }
LoanexToy class >> importanceValueLow [

	^ 'Low'
]

{ #category : #accessing }
LoanexToy class >> importanceValueMedium [

	^ 'Medium'
]

{ #category : #accessing }
LoanexToy class >> importanceValues [

	^ OrderedCollection new
		add: self importanceValueHigh;
		add: self importanceValueMedium;
		add: self importanceValueLow;
		yourself
]

{ #category : #voyage }
LoanexToy class >> isVoyageRoot [

	^ true
]

{ #category : #voyage }
LoanexToy class >> mongoCompleteByDate [
	<voyageDescription>

	^ VOToOneDescription new
		attributeName: 'completeByDate';
		accessor: (MAPluggableAccessor
			read: [ :todoItem | todoItem completeByDate ]
			write: [ :todoItem :value | todoItem completeByDate: value asDate ]);
		yourself
]

{ #category : #accessing }
LoanexToy >> calendars [
	^ calendars
]

{ #category : #accessing }
LoanexToy >> calendars: anObject [
	calendars := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> calendarsDescription [

	<magritteDescription>
	^ MAMultipleOptionDescription new
		accessor: #calendars;
		label: 'Calendars';
		cssClass: 'mcw-textfield';
		priority: 110;
		options: #(Home Work Vacation Secret);
		reference: MASymbolDescription new;
		yourself
]

{ #category : #accessing }
LoanexToy >> colorCode [
	^ colorCode
]

{ #category : #accessing }
LoanexToy >> colorCode: anObject [
	colorCode := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> colorCodeDescription [
	<magritteDescription>

	^ MAColorDescription new
		accessor: #colorCode;
		default: Color white;
		label: 'Color Code';
		cssClass: 'mcw-textfield';
		priority: 90;
		yourself
]

{ #category : #accessing }
LoanexToy >> completeBy [

	^ completeByDate asDate yyyymmdd, ' ', completeByTime print24
]

{ #category : #accessing }
LoanexToy >> completeByDate [
	^ completeByDate
]

{ #category : #accessing }
LoanexToy >> completeByDate: anObject [
	completeByDate := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> completeByDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #completeByDate;
		default: Date today;
		label: 'Complete By Date';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself

]

{ #category : #'accessing-magritte' }
LoanexToy >> completeByDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #completeBy;
		label: 'Complete By';
		cssClass: 'mcw-textfield';
		priority: 200;
		beReadonly;
		yourself

]

{ #category : #accessing }
LoanexToy >> completeByTime [
	^ completeByTime
]

{ #category : #accessing }
LoanexToy >> completeByTime: anObject [
	completeByTime := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> completeByTimeDescription [
	<magritteDescription>

	^ MATimeDescription new
		accessor: #completeByTime;
		label: 'Complete By Time';
		cssClass: 'mcw-textfield';
		priority: 40;
		yourself
]

{ #category : #accessing }
LoanexToy >> description [
	^ description
]

{ #category : #accessing }
LoanexToy >> description: anObject [
	description := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> descriptionDescription [
	<magritteDescription>

	^ MAMemoDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #accessing }
LoanexToy >> done [
	^ done
]

{ #category : #accessing }
LoanexToy >> done: anObject [
	done := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> doneDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #done;
		label: 'Done';
		cssClass: 'mcw-textfield';
		priority: 10;
		default: false;
		yourself
]

{ #category : #accessing }
LoanexToy >> estimatedDuration [
	^ estimatedDuration
]

{ #category : #accessing }
LoanexToy >> estimatedDuration: anObject [
	estimatedDuration := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> estimatedDurationDescription [
	<magritteDescription>

	^ MADurationDescription new
		accessor: #estimatedDuration;
		label: 'Estimated Duration';
		cssClass: 'mcw-textfield';
		priority: 50;
		yourself
]

{ #category : #accessing }
LoanexToy >> importance [
	^ importance
]

{ #category : #accessing }
LoanexToy >> importance: anObject [
	importance := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> importanceDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #importance;
		label: 'Importance';
		cssClass: 'mcw-textfield';
		options: self class importanceValues;
		priority: 80;
		yourself
]

{ #category : #accessing }
LoanexToy >> importanceIsHigh [

	^ self importance = self class importanceValueHigh
]

{ #category : #accessing }
LoanexToy >> importanceIsLow [

	^ self importance = self class importanceValueLow
]

{ #category : #accessing }
LoanexToy >> importanceIsMedium [

	^ self importance = self class importanceValueMedium
]

{ #category : #initialization }
LoanexToy >> initialize [

	super initialize.

	self done: false.
	self summary: String new.
	self description: String new.
	self completeByDate: Date today.
	self completeByTime: Time now.
	self estimatedDuration: 1 hour.
	self priority: 0.
	self importance: self class importanceValueMedium.
	self colorCode: Color new.
	self calendars: OrderedCollection new.

]

{ #category : #'accessing-magritte' }
LoanexToy >> isVoyageRoot [
	^ true
]

{ #category : #printing }
LoanexToy >> mdPrimaryString [

	^ self summary
]

{ #category : #printing }
LoanexToy >> mdSecondaryString [

	^ (self done ifTrue: [ 'DONE' ] ifFalse: [ 'NOT-DONE' ]),
		', ', 'Priority ', self priority printString,
		', ', 'Complete by  ', self completeByDate printString
]

{ #category : #accessing }
LoanexToy >> priority [
	^ priority
]

{ #category : #accessing }
LoanexToy >> priority: anObject [
	priority := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> priorityDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #priority;
		default: 0;
		label: 'Priority';
		cssClass: 'mcw-textfield';
		priority: 60;
		beInteger;
		mcwSliderStep: 1;
		mcwComponentClass: MCWSliderComponent;
		yourself
]

{ #category : #accessing }
LoanexToy >> summary [
	^ summary
]

{ #category : #accessing }
LoanexToy >> summary: anObject [
	summary := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> summaryDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #summary;
		default: '';
		label: 'Summary';
		cssClass: 'mcw-textfield';
		priority: 15;
		beRequired;
		yourself
]
